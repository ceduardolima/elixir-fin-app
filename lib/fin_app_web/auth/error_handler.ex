defmodule FinAppWeb.Auth.ErrorHandler.Unauthorized do
  defexception message: "Unauthorized", plug_status: 401
end
