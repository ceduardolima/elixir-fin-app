defmodule FinAppWeb.AccountController do
  use FinAppWeb, :controller

  alias FinAppWeb.Auth.{Guardian, ErrorHandler}
  alias FinApp.{Accounts, Users}
  alias FinApp.{Accounts.Account, Users.User}
  import Logger

  action_fallback FinAppWeb.FallbackController

  plug :is_authorized_account when action in [:update, :delete]

  defp is_authorized_account(conn, _opts) do
    %{params: params} = conn
    account = Accounts.get_account!(params["id"])
    Logger.info("account: #{inspect(account.id)}")

    if conn.assigns.id == account.id do
      conn
    else
      raise ErrorHandler.Forbidden
    end
  end

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def sign_in(conn, %{"email" => email, "hash_password" => hash_password}) do
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

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(account),
         {:ok, %User{} = _user} <- Users.create_user(account, account_params) do
      conn
      |> put_status(:created)
      |> render(:show_account_token, %{account: account, token: token})
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
