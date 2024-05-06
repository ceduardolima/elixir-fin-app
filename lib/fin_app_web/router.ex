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

    # Endpoint dos Accounts 
    get "/accounts/current", AccountController, :current_account
    get "/accounts/sign_out", AccountController, :sign_out
    get "/accounts/by_id/:id", AccountController, :show
    get "/accounts/refresh_session", AccountController, :refresh_session
    post "/accounts/update", AccountController, :update_password

    # Endpoint dos Users
    put "/:user_id/users/update", UserController, :update

    # Endpoint dos Expenses 
    get "/:user_id/expenses", ExpenseController, :index
    get "/:user_id/expenses/:id", ExpenseController, :show
    post "/:user_id/expenses/create", ExpenseController, :create
    put "/:user_id/expenses/update", ExpenseController, :update
    delete "/:user_id/expenses", ExpenseController, :delete

    # Endpoint das Tags
    post "/:user_id/tags", TagController, :create
    get "/:user_id/tags/:tag_id", TagController, :show
    put "/:user_id/tags/:tag_id", TagController, :update
    delete "/:user_id/tags/:tag_id", TagController, :delete

    post "/:user_id/tags/relation", TagExpenseController, :create
    get "/:user_id/tags/expense/:expense_id", TagController, :show_tags_from_expense
    delete "/:user_id/tags/expense/:relation_id", TagController, :delete
  end
end
