defmodule Workshop.Router do
  use Workshop.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Workshop.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Workshop do
    pipe_through :browser # Use the default browser stack
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    get "/", PageController, :index
    delete "/logout", SessionController, :delete
    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create
    resources "/users", UserController
    
    # moved to below to illustrate a json controller
    #resources "/posts", PostController
  end

  # Other scopes may use custom stacks.
  scope "/api", Workshop do
    pipe_through :api
    # pull posts thru api
    resources "/posts", PostController, except: [:new, :edit]
  end
end
