defmodule FinAppWeb.Auth.ErrorHandler.Unauthorized do
  defexception message: "Não authorizado", plug_status: 401
end

defmodule FinAppWeb.Auth.ErrorHandler.Forbidden do
  defexception message: "Acesso negado", plug_status: 403
end

defmodule FinAppWeb.Auth.ErrorHandler.NotFound do
  defexception [message: "Não encontrado", plug_status: 404]
end
