defmodule FinApp.Repo.Migrations.CreateUsersExpenses do
  use Ecto.Migration

  def change do
    create table(:users_expenses, primary_key: false) do
      add :user_id, references(:users, prefix: "profile", on_delete: :delete_all, on_update: :update_all, type: :binary_id)
      add :expenses_id, references(:expenses, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:users_expenses, [:user_id])
    create index(:users_expenses, [:expenses_id])
  end
end
