defmodule FinAppWeb.Auth.Guardian do
  use Guardian, otp_app: :fin_app
  alias FinApp.Accounts

  def subject_for_token(%{id: id}, _claims), do: {:ok, to_string(id)}

  def subject_for_token(_, _), do: {:error, :no_id_provided}

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_account!(id) do
      nil -> {:error, :not_found}
      resources -> {:ok, resources}
    end
  end

  def resource_from_claims(_) do
    {:error, :no_id_provided}
  end

  @doc """
    Realiza a autenticação do usuário;

    Ex:
      iex> Guardian.authenticate(valid_email, valid_password)
          {:ok, account, token}

      iex> Guardian.authenticate(invalid_email, invalid_password)
          {:error, :unauthorized}
  """
  def authenticate(email, hash_password) do
    case Accounts.get_account_by_email(email) do
      nil ->
        {:error, :unauthorized}

      account ->
        case validate_password(hash_password, account.hash_password) do
          true -> create_token(account)
          false -> {:error, :unauthorized}
        end
    end
  end

  defp validate_password(password, hash_password) do
    Bcrypt.verify_pass(password, hash_password)
  end

  defp create_token(account) do
    {:ok, token, _claims} = encode_and_sign(account)
    {:ok, account, token}
  end
end
