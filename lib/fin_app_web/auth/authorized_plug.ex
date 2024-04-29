defmodule FinAppWeb.Auth.AuthorizedPlug do
  alias FinAppWeb.Auth.ErrorHandler
  require Logger

  def is_authorized(%{params: %{"id" => id}} = conn, _opts) do
    if conn.assigns.account.id == id do
      conn
    else
      raise ErrorHandler.Forbidden
    end
  end

  def is_authorized(%{params: %{"user" => params}} = conn, _opts) do
    if conn.assigns.account.user.id == params["id"] do
      conn
    else
      raise ErrorHandler.Forbidden
    end
  end

  def is_authorized(%{params: %{"expense" => params}} = conn, _opts) do
    if conn.assigns.account.user.id == params["user_id"] do
      conn
    else
      raise ErrorHandler.Forbidden
    end
  end
end
