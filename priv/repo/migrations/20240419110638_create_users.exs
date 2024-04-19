defmodule FinApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false, prefix: "profile") do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :last_name, :string
      add :nickname, :string
      add :birthday, :date
      add :account_id, references(:accounts, on_delete: :delete_all, on_update: :update_all, type: :binary_id, prefix: "profile")

      timestamps(type: :utc_datetime)
    end

    create index(:users, [:account_id], prefix: "profile")
  end
end
