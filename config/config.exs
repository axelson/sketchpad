import Config

# General application configuration
config :sketchpad,
  ecto_repos: [Sketchpad.Repo]

# Configures the endpoint
config :sketchpad, SketchpadWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BCqHloAfzORpn/TX90PB9GULWVRZpjwegD4U8T1on/RUmEYTjkVGLC2YKFhkhLiS",
  render_errors: [view: SketchpadWeb.ErrorView, accepts: ~w(html json)],
  check_origin: false,
  pubsub_server: Sketchpad.PubSub

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
