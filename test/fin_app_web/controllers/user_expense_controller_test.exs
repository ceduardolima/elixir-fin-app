defmodule FinAppWeb.UserExpenseControllerTest do
  use FinAppWeb.ConnCase

  import FinApp.ExpensesFixtures

  alias FinApp.Expenses.UserExpense

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users_expenses", %{conn: conn} do
      conn = get(conn, ~p"/api/users_expenses")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user_expense" do
    test "renders user_expense when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/users_expenses", user_expense: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/users_expenses/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/users_expenses", user_expense: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user_expense" do
    setup [:create_user_expense]

    test "renders user_expense when data is valid", %{conn: conn, user_expense: %UserExpense{id: id} = user_expense} do
      conn = put(conn, ~p"/api/users_expenses/#{user_expense}", user_expense: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/users_expenses/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user_expense: user_expense} do
      conn = put(conn, ~p"/api/users_expenses/#{user_expense}", user_expense: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user_expense" do
    setup [:create_user_expense]

    test "deletes chosen user_expense", %{conn: conn, user_expense: user_expense} do
      conn = delete(conn, ~p"/api/users_expenses/#{user_expense}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/users_expenses/#{user_expense}")
      end
    end
  end

  defp create_user_expense(_) do
    user_expense = user_expense_fixture()
    %{user_expense: user_expense}
  end
end
