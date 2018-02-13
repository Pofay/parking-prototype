# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :parking_prototype,
  ecto_repos: [ParkingPrototype.Repo]

# Configures the endpoint
config :parking_prototype, ParkingPrototypeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0ismwL4YemzAO5zUadDgvqtkuamP5D0Nj2TnYekZGmeq3rQlAp8DSBr2V783TnQF",
  render_errors: [view: ParkingPrototypeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ParkingPrototype.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
