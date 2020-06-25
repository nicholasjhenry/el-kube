# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :el_kube,
  ecto_repos: [ElKube.Repo]

# Configures the endpoint
config :el_kube, ElKubeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0kh1tHYDgmlmQNQiQJLq5R6YMU5pm4k6at55LmYyyshoaHH72uw2kIlIH7V8+YzX",
  render_errors: [view: ElKubeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ElKube.PubSub,
  live_view: [signing_salt: "xJAI4Bhz"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
