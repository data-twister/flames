# Flames [![hex.pm version](https://img.shields.io/hexpm/v/flames.svg)](https://hex.pm/packages/flames) [![Build Status](https://travis-ci.org/data-twister/flames.svg?branch=master)](https://travis-ci.org/data-twister/flames)

![Example Dashboard](example.png)

## Installation

The package can be installed as:

  1. Add `flames` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:flames, git: "https://github.com/data-twister/flames.git", tag: "1.4.1"}]
    end
    ```
    # tags follow the version pf phx with revisions as alpha ie. 1.4.1 means revsison a is based on phx 1.4.1

  2. Ensure `flames` is started before your application:

    ```elixir
    def application do
      [applications: [:flames]]
    end
    ```

  3. Add configuration to tell `flames` what your repository and (optional) Phoenix Endpoint modules are as well as adding it as a Logger backend, to use liveview you must set the signing salt to something other than "YOUR_SECRET" or nil otherwise it defaults to using the react app:

    ```elixir
    config :flames,
      repo: MyPhoenixApp.Repo,
      endpoint: MyPhoenixApp.Endpoint,
      table: "errors" # Optional, defaults to "errors"

    config :logger,
      backends: [:console, Flames.Logger]

    config:  MyPhoenixApp.Endpoint,
       live_view: [
    signing_salt: "YOUR_SECRET"
  ]

  config :phoenix,
  template_engines: [leex: Phoenix.LiveView.Engine]
    ```

  1. Add the following migration:

  ```elixir
  defmodule MyApp.Repo.Migrations.CreateFlamesTable do
    use Ecto.Migration

    def change do
      # Make sure this table name matches the above configuration
      create table(:errors) do
        add :message, :text
        add :level, :string
        add :timestamp, :native_datetime 
        add :alive, :boolean
        add :module, :string
        add :function, :string
        add :file, :string
        add :line, :integer
        add :count, :integer
        add :hash, :string
        add :resolved, :string

        add :incidents, Flames.Error.Incident

        timestamps()
      end

      create index(:errors, [:hash])
      create index(:errors, [:updated_at])
    end
  end
  ```

  1. (Optional) Add it to your Phoenix Router and Phoenix Endpoint for live updates:

  Router (You should place this under a secure pipeline and secure it yourself)
  ```elixir
  forward "/system/errors", Flames.Web
  ```

  Endpoint (Make sure this is the full path, adding `/socket` to the end)
  ```elixir
  socket "/errors/socket", Flames.UserSocket
  socket("/errors/websocket", Phoenix.LiveView.Socket)
  ```
or
  ```elixir
 use Flames.Endpoint
  ```

  2. you will need to change the endpoint in app.js to match your live endpoint /errors is the default

  Visit http://localhost:4000/errors (or wherever you mounted it) to see a live stream of errors.
