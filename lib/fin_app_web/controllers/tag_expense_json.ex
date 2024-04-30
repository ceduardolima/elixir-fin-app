defmodule FinAppWeb.TagExpenseJSON do
  alias FinApp.TagsExpenses.TagExpense

  @doc """
  Renders a list of tags_expenses.
  """
  def index(%{tags_expenses: tags_expenses}) do
    %{data: for(tag_expense <- tags_expenses, do: data(tag_expense))}
  end

  @doc """
  Renders a single tag_expense.
  """
  def show(%{tag_expense: tag_expense}) do
    %{data: data(tag_expense)}
  end

  defp data(%TagExpense{} = tag_expense) do
    %{
      id: tag_expense.id
    }
  end
end
