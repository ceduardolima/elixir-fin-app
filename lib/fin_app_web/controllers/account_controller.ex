defmodule FinAppWeb.AccountController do
  use FinAppWeb, :controller

  alias FinAppWeb.Auth.{Guardian, ErrorHandler}
  alias FinApp.{Accounts, Users}
  alias FinApp.{Accounts.Account, Users.User}
  import FinAppWeb.Auth.AuthorizedPlug
  require Logger

  action_fallback FinAppWeb.FallbackController

  plug :is_authorized when action in [:update_password, :delete]

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
    {:ok, account, new_token} = Guardian.authenticate(current_token)

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
    account = Accounts.get_full_account(id)
    render(conn, :full_account, account: account)
  end

  def current_account(conn, %{}) do
    conn |> put_status(:ok) |> render(:full_account, %{account: conn.assigns.account})
  end

  def update_password(conn, %{"current_hash" => current_hash, "hash_password" => password}) do
    case Guardian.validate_password(current_hash, conn.assigns.account.hash_password) do
      true ->
        {:ok, account} =
          Accounts.update_account(conn.assigns.account, %{hash_password: password})

        render(conn, :show, account: account)

      false ->
        raise ErrorHandler.Unauthorized, message: "Senha incorreta"
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
