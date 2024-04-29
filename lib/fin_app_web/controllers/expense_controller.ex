defmodule FinAppWeb.ExpenseController do
  use FinAppWeb, :controller

  alias FinApp.Expenses
  alias FinApp.Expenses.Expense
  import FinAppWeb.Auth.AuthorizedPlug
  require Logger

  plug :is_authorized when action in [:create]

  action_fallback FinAppWeb.FallbackController

  def index(conn, _params) do
    Logger.info("user_id: #{conn.assigns.account.user.id}\n\n")
    expenses = Expenses.list_expenses(conn.assigns.account.user.id)
    render(conn, :index, expenses: expenses)
  end

  def create(conn, %{"expense" => expense_params}) do
    with {:ok, %Expense{} = expense} <-
           Expenses.create_expense(expense_params) do
      conn
      |> put_status(:created)
      |> render(:show, expense: expense)
    end
  end

  def show(conn, %{"id" => id}) do
    expense = Expenses.get_expense!(id)
    render(conn, :show, expense: expense)
  end

  def update(conn, %{"id" => id, "expense" => expense_params}) do
    expense = Expenses.get_expense!(id)

    with {:ok, %Expense{} = expense} <- Expenses.update_expense(expense, expense_params) do
      render(conn, :show, expense: expense)
    end
  end

  def delete(conn, %{"id" => id}) do
    expense = Expenses.get_expense!(id)

    with {:ok, %Expense{}} <- Expenses.delete_expense(expense) do
      send_resp(conn, :no_content, "")
    end
  end
end
