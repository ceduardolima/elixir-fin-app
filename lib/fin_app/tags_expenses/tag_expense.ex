defmodule FinApp.TagsExpenses.TagExpense do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tags_expenses" do
    belongs_to :expense, FinApp.Expenses.Expense
    belongs_to :tag, FinApp.Tags.Tag

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tag_expense, attrs) do
    tag_expense
    |> cast(attrs, [])
    |> validate_required([])
  end
end
