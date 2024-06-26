defmodule FinAppWeb.TagController do
  use FinAppWeb, :controller

  alias FinApp.Tags
  alias FinApp.TagsExpenses.TagExpense
  alias FinApp.Tags.Tag
  alias FinApp.Expenses
  import FinAppWeb.Auth.AuthorizedPlug
  require Logger

  plug :is_authorized

  action_fallback FinAppWeb.FallbackController

  def index(conn, _params) do
    tags = Tags.list_tags()
    render(conn, :index, tags: tags)
  end

  @doc """
    Json de request:
    {
      color: "#FF01ABF5",
      name: "Tag 1",
      expense_id: "abcdef-01"
    }
  """
  def create(conn, %{"user_id" => user_id, "tag" => tag_params}) do
    with {:ok, %Tag{} = tag} <- Tags.create_tag(tag_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/#{user_id}/tags/#{tag.id}")
      |> render(:show, tag: tag)
    end
  end

  def show(conn, %{"tag_id" => id}) do
    tag = Tags.get_tag!(id)
    Logger.info(inspect(tag))
    render(conn, :show, tag: tag)
  end

  def show_tags_from_expense(conn, %{"expense_id" => id}) do
    tags = FinApp.TagsExpenses.get_tags_from_expense(id)
    render(conn, :index, tags: tags)
  end

  def update(conn, %{"tag_id" => id, "tag" => tag_params}) do
    tag = Tags.get_tag!(id)

    with {:ok, %Tag{} = tag} <- Tags.update_tag(tag, tag_params) do
      conn |> put_status(:ok) |> render(:show, tag: tag)
    end
  end

  def delete(conn, %{"tag_id" => id}) do
    tag = Tags.get_tag!(id)

    with {:ok, %Tag{}} <- Tags.delete_tag(tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
