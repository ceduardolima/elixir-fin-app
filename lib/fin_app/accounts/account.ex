defmodule FinApp.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset
  require Logger

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @schema_prefix "profile"
  schema "accounts" do
    field :hash_password, :string
    field :email, :string
    has_one :user, FinApp.Users.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(account, attrs) do
    value = account
    |> cast(attrs, [:email, :hash_password])
    |> validate_required([:email, :hash_password])
    |> validate_format(:email, ~r/@/)
    |> put_password_hash()

    Logger.info("Valor changeset: #{inspect(value)}")

    value
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{hash_password: hash_password}} = changeset) do
    value = change(changeset, hash_password: Bcrypt.hash_pwd_salt(hash_password))
    Logger.info("changeset hash: #{inspect(value)}")
    value
  end

  defp put_password_hash(changeset) do
    changeset
  end
end
