# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :my_zwave_api, MyZwaveApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "b/8Bg95PZNq8PX5IDwqpC95buWMN6ztB4s5KlVDhZfxtGnxkf0nMEoYgyBC/DTTS",
  render_errors: [view: MyZwaveApiWeb.ErrorView, accepts: ~w(json), default_format: "json", layout: false],
  pubsub_server: MyZwaveApi.PubSub,
  live_view: [signing_salt: "vkQLKdal"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
