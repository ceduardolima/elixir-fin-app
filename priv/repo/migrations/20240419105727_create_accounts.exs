defmodule FinApp.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false, prefix: "profile") do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :hash_password, :string

      timestamps(type: :utc_datetime)
    end

    create index(:accounts, [:email], prefix: "profile")
  end
end
