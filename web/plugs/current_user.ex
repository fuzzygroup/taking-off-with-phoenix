defmodule Workshop.CurrentUser do 
  import Plug.Conn
  
  alias Workshop.{Repo, User}
  
  def init(opts), do: opts
  
  def call(conn, _) do
    assign(conn, :current_user, user_from_session(conn))
  end
  
  
  defp user_from_session(conn) do
    case get_session(conn, :current_user_id) do
      nil -> nil
      # JSJ
      # next line is superceded by the line below it which uses the alias
      #val -> Workshop.Repo.get(Workshop.User, val)      
      val -> Repo.get(User, val)
    end
  end
end