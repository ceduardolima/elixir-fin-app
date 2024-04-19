defmodule FinApp.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @schema_prefix "profile"
  schema "users" do
    field :name, :string
    field :last_name, :string
    field :nickname, :string
    field :birthday, :date
    belongs_to :account, FinApp.Accounts.Account

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :last_name, :nickname, :account_id])
    |> validate_required([:name, :last_name, :account_id])
    |> unique_constraint(:account_id)
  end
end
