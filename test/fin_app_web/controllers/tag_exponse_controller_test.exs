defmodule FinAppWeb.TagExpenseControllerTest do
  use FinAppWeb.ConnCase

  import FinApp.TagsExpensesFixtures

  alias FinApp.TagsExpenses.TagExpense

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tags_expenses", %{conn: conn} do
      conn = get(conn, ~p"/api/tags_expenses")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create tag_expense" do
    test "renders tag_expense when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/tags_expenses", tag_expense: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/tags_expenses/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/tags_expenses", tag_expense: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update tag_expense" do
    setup [:create_tag_expense]

    test "renders tag_expense when data is valid", %{conn: conn, tag_expense: %TagExpense{id: id} = tag_expense} do
      conn = put(conn, ~p"/api/tags_expenses/#{tag_expense}", tag_expense: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/tags_expenses/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, tag_expense: tag_expense} do
      conn = put(conn, ~p"/api/tags_expenses/#{tag_expense}", tag_expense: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete tag_expense" do
    setup [:create_tag_expense]

    test "deletes chosen tag_expense", %{conn: conn, tag_expense: tag_expense} do
      conn = delete(conn, ~p"/api/tags_expenses/#{tag_expense}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/tags_expenses/#{tag_expense}")
      end
    end
  end

  defp create_tag_expense(_) do
    tag_expense = tag_expense_fixture()
    %{tag_expense: tag_expense}
  end
end
