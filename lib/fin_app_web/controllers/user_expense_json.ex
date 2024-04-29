defmodule FinAppWeb.UserExpenseJSON do
  alias FinApp.Expenses.UserExpense

  @doc """
  Renders a list of users_expenses.
  """
  def index(%{users_expenses: users_expenses}) do
    %{data: for(user_expense <- users_expenses, do: data(user_expense))}
  end

  @doc """
  Renders a single user_expense.
  """
  def show(%{user_expense: user_expense}) do
    %{data: data(user_expense)}
  end

  defp data(%UserExpense{} = user_expense) do
    %{
      id: user_expense.id
    }
  end
end
