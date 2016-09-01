defmodule Workshop.SessionController do 
  use Workshop.Web, :controller
  
  alias Workshop.User
  
  # JSJ
  # IMPORTANT_NOTE the _ means we can ignore this parameter
  def delete(conn, _) do
    # user = conn.assigns.current_user
    conn
    # JSJ
    #|> put_flash("You're logged out")
    # overwrites the user with an id nil
    #|> put_session(:current_user_id, nil)
    |> configure_session(drop: true)
    |> redirect(to: page_path(conn, :index))
  end
  
  def new(conn, _) do
    render conn, "new.html"
  end
  
  # JSJ
  # pattern match on the data within the session
  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    user = Repo.get_by(User, email: email)
    
    if user && Comeonin.Bcrypt.checkpw(password, user.hashed_password) do
      conn
      |> put_flash(:info, "You are logged in")
      |> put_session(:current_user_id, user.id)
      |> redirect(to: page_path(conn, :index))
    else
      # JSJ
      # force a random wait state to defeat timing attachs
      Comeonin.Bcrypt.dummy_checkpw()
      conn
      |> put_flash(:error, "incorrect email or password")
      |> render("new.html")
    end
  end
  
end