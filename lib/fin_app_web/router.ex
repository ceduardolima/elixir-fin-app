defmodule FinAppWeb.Router do
  use FinAppWeb, :router
  use Plug.ErrorHandler

  @impl Plug.ErrorHandler
  def handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn
    |> json(%{errors: message})
    |> halt()
  end

  @impl Plug.ErrorHandler
  def handle_errors(conn, %{reason: %{message: message}}) do
    conn
    |> json(%{errors: message})
    |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug FinAppWeb.Auth.Pipeline
    plug FinAppWeb.Auth.SetAccount
  end

  scope "/", FinAppWeb do
    pipe_through :api
    post "/login", AccountController, :sign_in
    post "/accounts", AccountController, :create
  end

  scope "/", FinAppWeb do
    pipe_through [:api, :auth]
    get "/accounts/current", AccountController, :current_account
    get "/accounts/sign_out", AccountController, :sign_out
    get "/accounts/by_id/:id", AccountController, :show
    get "/accounts/refresh_session", AccountController, :refresh_session
    post "/accounts/update", AccountController, :update_password
    put "/users/update", UserController, :update
  end
end
