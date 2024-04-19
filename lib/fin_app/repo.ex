defmodule FinApp.Repo do
  use Ecto.Repo,
    otp_app: :fin_app,
    adapter: Ecto.Adapters.Postgres
end
