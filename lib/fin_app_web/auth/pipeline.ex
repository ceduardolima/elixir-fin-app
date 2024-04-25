defmodule FinAppWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :fin_app,
    error_handler: FinAppWeb.Auth.GuardianErrorHandler,
    module: FinAppWeb.Auth.Guardian

  
  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
