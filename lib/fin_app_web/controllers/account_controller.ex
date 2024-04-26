defmodule FinAppWeb.AccountController do
  use FinAppWeb, :controller

  alias FinAppWeb.Auth.{Guardian, ErrorHandler}
  alias FinApp.{Accounts, Users}
  alias FinApp.{Accounts.Account, Users.User}
  require Logger

  action_fallback FinAppWeb.FallbackController

  plug :is_authorized_account when action in [:update_password, :delete]

  defp is_authorized_account(conn, _opts) do
    %{params: params} = conn

    case Accounts.get_account(params["id"]) do
      {:ok, account} when conn.assigns.account.id == account.id ->
        conn

      _ ->
        raise ErrorHandler.Forbidden
    end
  end

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def sign_in(conn, %{"email" => email, "hash_password" => hash_password}) do
    authorize_account(conn, email, hash_password)
  end

  defp authorize_account(conn, email, hash_password) do
    case Guardian.authenticate(email, hash_password) do
      {:ok, account, token} ->
        conn
        |> Plug.Conn.put_session(:account_id, account.id)
        |> put_status(:ok)
        |> render(:show_account_token, %{account: account, token: token})

      {:error, :unauthorized} ->
        raise ErrorHandler.Unauthorized, message: "Não authorizado"
    end
  end

  def refresh_session(conn, %{}) do
    current_token = Guardian.Plug.current_token(conn)
    {:ok, :account, token} = Guardian.authenticate(current_token)

    conn
    |> Plug.Conn.put_session(:account_id, account.id)
    |> put_status(:ok)
    |> render(:show_account_token, %{account: account, token: new_token})
  end

  def sign_out(%Plug.Conn{request_path: "/accounts/sign_out"} = conn, _params) do
    Logger.info("\n\n #{inspect(conn)}")
    account = conn.assigns[:account]
    token = Guardian.Plug.current_token(conn)
    Guardian.revoke(token)

    conn
    |> Plug.Conn.clear_session()
    |> put_status(:ok)
    |> render(:show_account_token, %{account: account, token: nil})
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
         {:ok, %User{} = _user} <- Users.create_user(account, account_params) do
      authorize_account(conn, account.email, account_params["hash_password"])
    end
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  def update_password(conn, %{"id" => id, "hash_password" => password}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{} = _account_updated} <-
           Accounts.update_account(account, %{hash_password: password}) do
      send_resp(conn, 200, "Senha atualizada com sucesso!")
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
