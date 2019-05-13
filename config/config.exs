# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :flames,
  repo: FakeRepo,
  endpoint: FakeEndpoint,
  live_view: [
    signing_salt: "YOUR_SECRET"
  ]

config :phoenix,
  template_engines: [leex: Phoenix.LiveView.Engine]
