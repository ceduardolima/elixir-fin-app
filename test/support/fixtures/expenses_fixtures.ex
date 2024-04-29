defmodule FinApp.ExpensesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FinApp.Expenses` context.
  """

  @doc """
  Generate a expense.
  """
  def expense_fixture(attrs \\ %{}) do
    {:ok, expense} =
      attrs
      |> Enum.into(%{
        name: "some name",
        value: "120.5"
      })
      |> FinApp.Expenses.create_expense()

    expense
  end
end
