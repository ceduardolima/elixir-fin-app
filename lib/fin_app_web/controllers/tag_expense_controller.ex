defmodule FinAppWeb.TagExpenseController do
  use FinAppWeb, :controller

  alias FinApp.TagsExpenses
  alias FinApp.TagsExpenses.TagExpense

  action_fallback FinAppWeb.FallbackController

  def index(conn, _params) do
    tags_expenses = TagsExpenses.list_tags_expenses()
    render(conn, :index, tags_expenses: tags_expenses)
  end

  def create(conn, %{"tag_expense" => tag_expense_params}) do
    with {:ok, %TagExpense{} = tag_expense} <- TagsExpenses.create_tag_expense(tag_expense_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/tags_expenses/#{tag_expense}")
      |> render(:show, tag_expense: tag_expense)
    end
  end

  def show(conn, %{"id" => id}) do
    tag_expense = TagsExpenses.get_tag_expense!(id)
    render(conn, :show, tag_expense: tag_expense)
  end

  def update(conn, %{"id" => id, "tag_expense" => tag_expense_params}) do
    tag_expense = TagsExpenses.get_tag_expense!(id)

    with {:ok, %TagExpense{} = tag_expense} <- TagsExpenses.update_tag_expense(tag_expense, tag_expense_params) do
      render(conn, :show, tag_expense: tag_expense)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag_expense = TagsExpenses.get_tag_expense!(id)

    with {:ok, %TagExpense{}} <- TagsExpenses.delete_tag_expense(tag_expense) do
      send_resp(conn, :no_content, "")
    end
  end
end
