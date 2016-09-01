defmodule Workshop.RegistrationController do
  use Workshop.Web, :controller 
  
  # def action(conn, []) do
  #   user = conn.assigns[:user]
  #   apply(__MODULE__, :new, [conn, user, conn.params])
  # end
  
  alias Workshop.User

  # JSJ
  # IF NOT use a variable then PREFIX it with an _
  def new(conn, _params) do
    changeset = User.changeset(%User{})
    # JSJ
    # double quoted strings are almost always what you want; a single quote means you have a list of characters
    render conn, "new.html", changeset: changeset
  end 
  
  def create(conn, %{"user" => user_params} = params) do
    #IO.inspect params
    changeset = User.changeset(%User{}, user_params)
    
    # JSJ
    #pattern matching VERSUS if/else
    case Repo.insert(changeset) do
      {:ok, user} -> 
        conn
        |> put_flash(:info, "Great Success!")
        |> put_session(:current_user_id, user.id)
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} -> 
        conn
        |> render("new.html", changeset: changeset)
    end
    
    #conn
  end
  
end