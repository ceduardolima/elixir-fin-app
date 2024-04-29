defmodule FinApp.Repo.Migrations.CreateRelationBetweenUserAndExpense do
  use Ecto.Migration

  def change do
    alter table("expenses") do
      add :user_id,
          references(:users,
            on_delete: :delete_all,
            on_update: :update_all,
            type: :binary_id,
            prefix: "profile"
          )
    end

    drop table("users_expenses")
  end
end
