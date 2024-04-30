defmodule FinApp.Repo.Migrations.CreateTagsExpenses do
  use Ecto.Migration

  def change do
    create table(:tags_expenses, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :tag_id,
          references(:tags, on_delete: :delete_all, on_update: :update_all, type: :binary_id)

      add :expense_id,
          references(:expenses, on_delete: :delete_all, on_update: :update_all, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:tags_expenses, [:tag_id])
    create index(:tags_expenses, [:expense_id])
  end
end
