defmodule FinApp.TagsExpensesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FinApp.TagsExpenses` context.
  """

  @doc """
  Generate a tag_expense.
  """
  def tag_expense_fixture(attrs \\ %{}) do
    {:ok, tag_expense} =
      attrs
      |> Enum.into(%{

      })
      |> FinApp.TagsExpenses.create_tag_expense()

    tag_expense
  end
end
