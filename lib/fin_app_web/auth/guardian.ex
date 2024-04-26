defmodule FinAppWeb.Auth.Guardian do
  use Guardian, otp_app: :fin_app
  alias FinApp.Accounts

#----------------------------------------------------
# -> Gerando o token do usuário



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
          true -> create_token(account, :access)
          false -> {:error, :unauthorized}
        end
    end
  end

  def authenticate(token) do
    with {:ok, claims} <- decode_and_verify(token),
    {:ok, account} <- resource_from_claims(claims),
    {:ok, _old, {new_token, _claims}} <- refresh(token) do
      {:ok, account, new_token}
    end
  end

  def validate_password(password, hash_password) do
    Bcrypt.verify_pass(password, hash_password)
  end

  defp create_token(account, type) do
    {:ok, token, _claims} = encode_and_sign(account, %{}, token_opts(type))
    {:ok, account, token}
  end

  defp token_opts(type) do 
    case type do 
      :access -> [token_type: "access", ttl: {2, :hour}]
      :reset -> [token_type: "reset", ttl: {15, :minutes}]
      :admin -> [token_type: "admin", ttl: {30, :days}]

    end 
  end

#----------------------------------------------------
# -> Salvando localmente o token e gerando um timeout

  def after_encode_and_sign(resource, claims, token, _options) do
    with {:ok, _} <- Guardian.DB.after_encode_and_sign(resource, claims["typ"], claims, token) do
      {:ok, token}
    end
  end

  def on_verify(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
      {:ok, claims}
    end
  end

  def on_refresh({old_token, old_claims}, {new_token, new_claims}, _options) do
    with {:ok, _, _} <- Guardian.DB.on_refresh({old_token, old_claims}, {new_token, new_claims}) do
      {:ok, {old_token, old_claims}, {new_token, new_claims}}
    end
  end

  def on_revoke(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_revoke(claims, token) do
      {:ok, claims}
    end
  end

end
