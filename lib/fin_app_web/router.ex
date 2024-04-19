defmodule FinAppWeb.Router do
  use FinAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FinAppWeb do
    pipe_through :api
  end
end
