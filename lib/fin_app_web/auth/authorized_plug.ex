defmodule FinAppWeb.Auth.AuthorizedPlug do
  alias FinAppWeb.Auth.ErrorHandler

  def is_authorized(%{params: %{"account" => params}} = conn, _opts) do
    if conn.assigns.account.id == params["id"] do
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
end
