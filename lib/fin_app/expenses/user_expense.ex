defmodule FinApp.Expenses.UserExpense do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "users_expenses" do
    field :user_id, :binary_id
    field :expenses_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_expense, attrs) do
    user_expense
    |> cast(attrs, [])
    |> validate_required([])
  end
end
