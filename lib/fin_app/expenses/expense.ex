defmodule FinApp.Expenses.Expense do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "expenses" do
    field :name, :string
    field :value, :decimal
    belongs_to :user, FinApp.Users.User
    has_many :tag_expense, FinApp.TagsExpenses.TagExpense

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [:name, :value, :user_id])
    |> validate_required([:name, :value, :user_id])
    |> validate_number(:value, greater_than_or_equal_to: 0, message: "O valor não pode ser negativo")
  end
end
