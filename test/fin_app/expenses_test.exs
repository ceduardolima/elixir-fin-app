defmodule FinApp.ExpensesTest do
  use FinApp.DataCase

  alias FinApp.Expenses

  describe "expenses" do
    alias FinApp.Expenses.Expense

    import FinApp.ExpensesFixtures

    @invalid_attrs %{name: nil, value: nil}

    test "list_expenses/0 returns all expenses" do
      expense = expense_fixture()
      assert Expenses.list_expenses() == [expense]
    end

    test "get_expense!/1 returns the expense with given id" do
      expense = expense_fixture()
      assert Expenses.get_expense!(expense.id) == expense
    end

    test "create_expense/1 with valid data creates a expense" do
      valid_attrs = %{name: "some name", value: "120.5"}

      assert {:ok, %Expense{} = expense} = Expenses.create_expense(valid_attrs)
      assert expense.name == "some name"
      assert expense.value == Decimal.new("120.5")
    end

    test "create_expense/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Expenses.create_expense(@invalid_attrs)
    end

    test "update_expense/2 with valid data updates the expense" do
      expense = expense_fixture()
      update_attrs = %{name: "some updated name", value: "456.7"}

      assert {:ok, %Expense{} = expense} = Expenses.update_expense(expense, update_attrs)
      assert expense.name == "some updated name"
      assert expense.value == Decimal.new("456.7")
    end

    test "update_expense/2 with invalid data returns error changeset" do
      expense = expense_fixture()
      assert {:error, %Ecto.Changeset{}} = Expenses.update_expense(expense, @invalid_attrs)
      assert expense == Expenses.get_expense!(expense.id)
    end

    test "delete_expense/1 deletes the expense" do
      expense = expense_fixture()
      assert {:ok, %Expense{}} = Expenses.delete_expense(expense)
      assert_raise Ecto.NoResultsError, fn -> Expenses.get_expense!(expense.id) end
    end

    test "change_expense/1 returns a expense changeset" do
      expense = expense_fixture()
      assert %Ecto.Changeset{} = Expenses.change_expense(expense)
    end
  end

  describe "users_expenses" do
    alias FinApp.Expenses.UserExpense

    import FinApp.ExpensesFixtures

    @invalid_attrs %{}

    test "list_users_expenses/0 returns all users_expenses" do
      user_expense = user_expense_fixture()
      assert Expenses.list_users_expenses() == [user_expense]
    end

    test "get_user_expense!/1 returns the user_expense with given id" do
      user_expense = user_expense_fixture()
      assert Expenses.get_user_expense!(user_expense.id) == user_expense
    end

    test "create_user_expense/1 with valid data creates a user_expense" do
      valid_attrs = %{}

      assert {:ok, %UserExpense{} = user_expense} = Expenses.create_user_expense(valid_attrs)
    end

    test "create_user_expense/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Expenses.create_user_expense(@invalid_attrs)
    end

    test "update_user_expense/2 with valid data updates the user_expense" do
      user_expense = user_expense_fixture()
      update_attrs = %{}

      assert {:ok, %UserExpense{} = user_expense} = Expenses.update_user_expense(user_expense, update_attrs)
    end

    test "update_user_expense/2 with invalid data returns error changeset" do
      user_expense = user_expense_fixture()
      assert {:error, %Ecto.Changeset{}} = Expenses.update_user_expense(user_expense, @invalid_attrs)
      assert user_expense == Expenses.get_user_expense!(user_expense.id)
    end

    test "delete_user_expense/1 deletes the user_expense" do
      user_expense = user_expense_fixture()
      assert {:ok, %UserExpense{}} = Expenses.delete_user_expense(user_expense)
      assert_raise Ecto.NoResultsError, fn -> Expenses.get_user_expense!(user_expense.id) end
    end

    test "change_user_expense/1 returns a user_expense changeset" do
      user_expense = user_expense_fixture()
      assert %Ecto.Changeset{} = Expenses.change_user_expense(user_expense)
    end
  end
end
