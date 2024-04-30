defmodule FinApp.TagsExpensesTest do
  use FinApp.DataCase

  alias FinApp.TagsExpenses

  describe "tags_expenses" do
    alias FinApp.TagsExpenses.TagExpense

    import FinApp.TagsExpensesFixtures

    @invalid_attrs %{}

    test "list_tags_expenses/0 returns all tags_expenses" do
      tag_expense = tag_expense_fixture()
      assert TagsExpenses.list_tags_expenses() == [tag_expense]
    end

    test "get_tag_expense!/1 returns the tag_expense with given id" do
      tag_expense = tag_expense_fixture()
      assert TagsExpenses.get_tag_expense!(tag_expense.id) == tag_expense
    end

    test "create_tag_expense/1 with valid data creates a tag_expense" do
      valid_attrs = %{}

      assert {:ok, %TagExpense{} = tag_expense} = TagsExpenses.create_tag_expense(valid_attrs)
    end

    test "create_tag_expense/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TagsExpenses.create_tag_expense(@invalid_attrs)
    end

    test "update_tag_expense/2 with valid data updates the tag_expense" do
      tag_expense = tag_expense_fixture()
      update_attrs = %{}

      assert {:ok, %TagExpense{} = tag_expense} = TagsExpenses.update_tag_expense(tag_expense, update_attrs)
    end

    test "update_tag_expense/2 with invalid data returns error changeset" do
      tag_expense = tag_expense_fixture()
      assert {:error, %Ecto.Changeset{}} = TagsExpenses.update_tag_expense(tag_expense, @invalid_attrs)
      assert tag_expense == TagsExpenses.get_tag_expense!(tag_expense.id)
    end

    test "delete_tag_expense/1 deletes the tag_expense" do
      tag_expense = tag_expense_fixture()
      assert {:ok, %TagExpense{}} = TagsExpenses.delete_tag_expense(tag_expense)
      assert_raise Ecto.NoResultsError, fn -> TagsExpenses.get_tag_expense!(tag_expense.id) end
    end

    test "change_tag_expense/1 returns a tag_expense changeset" do
      tag_expense = tag_expense_fixture()
      assert %Ecto.Changeset{} = TagsExpenses.change_tag_expense(tag_expense)
    end
  end
end
