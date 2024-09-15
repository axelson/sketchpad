# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :sketchpad,
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :sketchpad, SketchpadWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: SketchpadWeb.ErrorHTML, json: SketchpadWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Sketchpad.PubSub,
  live_view: [signing_salt: "SLfpf5Ha"]

# Configure esbuild (the version is required)
# config :esbuild,
#   version: "0.17.11",
#   sketchpad: [
#     args:
#       ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
#     cd: Path.expand("../assets", __DIR__),
#     env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
#   ]

config :esbuild,
  version: "0.14.41",
  default: [
    # ~w(js/app.js --bundle --minify --sourcemap=external --target=es2020 --outdir=../dist/js),
    args:
      ~w(js/app.js --bundle --minify --sourcemap=external --target=es2020 --outdir=../priv/static/assets/js),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :dart_sass,
  version: "1.61.0",
  default: [
    # args: ~w(--load-path=node_modules --no-source-map css/app.scss ../dist/css/app.css),
    args:
      ~w(--load-path=node_modules --no-source-map css/app.scss ../priv/static/assets/css/app.css),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
