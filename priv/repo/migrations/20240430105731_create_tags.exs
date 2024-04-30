defmodule FinApp.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :color, :string, size: 9
      add :name, :string, size: 30

      timestamps(type: :utc_datetime)
    end
  end
end
