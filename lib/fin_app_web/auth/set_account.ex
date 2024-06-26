defmodule FinAppWeb.Auth.SetAccount do
  import Plug.Conn
  alias FinAppWeb.Auth.ErrorHandler
  alias FinApp.Accounts
  require Logger

  def init(_options) do
  end

  def call(conn, _options) do
    Logger.info("account: #{inspect(conn.assigns[:account])}\n\n")
    
    if conn.assigns[:account] do
      conn
    else
      account_id = get_session(conn, :account_id)
      if account_id == nil, do: raise(ErrorHandler.Unauthorized)
      account = Accounts.get_full_account(account_id)
      Logger.info("account: #{inspect(account)}\n\n")

      cond do
        account_id && account -> assign(conn, :account, account)
        true -> assign(conn, :account, nil)
      end
    end
  end
end
