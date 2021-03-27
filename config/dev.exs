# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :flames, Flames.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

config :flames, Flames.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$"
    ]
  ]

config :flames,
  repo: FakeRepo,
  endpoint: Flames.Endpoint,
  live_view: [
    signing_salt: "YOUR_SECRET"
  ],
  live_reload: [
    patterns: [
      ~r{lib/web/templates/.*(ex)$}
    ]
  ]

config :phoenix,
  template_engines: [leex: Phoenix.LiveView.Engine]
