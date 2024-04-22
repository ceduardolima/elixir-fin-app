defmodule FinAppWeb.Router do
  use FinAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  scope "/", FinAppWeb do
    pipe_through :api
    post "/login", AccountController, :sign_in
    post "/accounts", AccountController, :create
    get "/accounts/:id", AccountController, :show
  end
end
