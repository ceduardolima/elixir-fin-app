defmodule FinAppWeb.Router do
  use FinAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FinAppWeb do
    pipe_through :api
    post "/accounts", AccountController, :create
    get "/accounts/:id", AccountController, :show
  end
end
