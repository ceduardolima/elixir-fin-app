defmodule FinAppWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :fin_app,
    error_handler: FinAppWeb.Auth.ErrorHanlder.Unauthorized,
    module: FinApp.Auth.Guardian

  
  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end
