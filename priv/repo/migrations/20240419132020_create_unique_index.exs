defmodule FinApp.Repo.Migrations.CreateUniqueIndex do
  use Ecto.Migration

  def change do
    drop index(:users, [:account_id], prefix: "profile")
    create unique_index(:users, [:account_id], prefix: "profile")

    drop index(:accounts, [:email], prefix: "profile")
    create unique_index(:accounts, [:email], prefix: "profile")
  end
end
