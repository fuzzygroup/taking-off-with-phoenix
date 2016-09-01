# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :workshop,
  ecto_repos: [Workshop.Repo]

# Configures the endpoint
config :workshop, Workshop.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+xx1RP2nmsGmpR2FL2jI0uwgAgmhxL3xUqYnP2E59ZjujekZCcgNyT45DfKciOjZ",
  render_errors: [view: Workshop.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Workshop.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]
  
# Configure the database  
config :workshop, Workshop.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "workshop_dev",
  hostname: "localhost",
  pool_size: 10

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
