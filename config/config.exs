# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :flames,
  repo: FakeRepo,
  endpoint: FakeEndpoint

# Configures the endpoint
config :flames, Flames.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "x/RaJMEfVCIDIzaCiG8Gn5sfg1CazZJt70wWspCTNpHzwp/B18xI4QLxW/z6fbny",
  render_errors: [view: Flames.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Flames.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "oel2QWyjS+f1wfbAvUqHs9keBohhqdIJ"
  ]

config :phoenix,
  template_engines: [leex: Phoenix.LiveView.Engine]

config :phoenix, :json_library, Jason

## add to endpoint   live_view: [
# signing_salt: "YOUR_SECRET"
# ]

import_config "#{Mix.env()}.exs"
