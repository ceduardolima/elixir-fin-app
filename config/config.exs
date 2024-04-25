# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :fin_app,
  ecto_repos: [FinApp.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :fin_app, FinAppWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: FinAppWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: FinApp.PubSub,
  live_view: [signing_salt: "1eGpFHKF"]


# Configurando o Guardian
config :fin_app, FinAppWeb.Auth.Guardian,
  issuer: "fin_app",
  secret_key: "efdZeJSss+bMxhP9MDDL+9I9qSRAFdzWcQ2uO7suGkKu28p10i0ARkKY9nVDvJ3t"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :guardian, Guardian.DB,
  repo: FinApp.Repo,
  schema_name: "guardian_tokens",
  sweep_interval: 60


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
