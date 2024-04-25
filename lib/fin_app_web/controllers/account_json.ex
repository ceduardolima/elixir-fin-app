defmodule FinAppWeb.AccountJSON do
  alias FinApp.Accounts.Account

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(account <- accounts, do: data(account))}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account}) do
    %{data: data(account)}
  end

  def show_account_token(%{account: account, token: token}) do
    %{
        id: account.id,
        email: account.email,
        token: token
    }
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      email: account.email,
      hash_password: account.hash_password
    }
  end

  def error_message(%{message: message}) do
    %{
      message: message
    }
  end
end
