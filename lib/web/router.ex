if Code.ensure_loaded?(Phoenix.Router) do
  defmodule Flames.Router do
    @moduledoc """
    """

    use Phoenix.Router

    def static_path(%Plug.Conn{script_name: script}, path),
      do: "/" <> Enum.join(script, "/") <> path

    pipeline :browser do
      plug(:accepts, ~w(html))
      plug(:fetch_session)
      plug(:protect_from_forgery)
      plug(:put_secure_browser_headers)
      plug(:fetch_flash)
    end

    pipeline :live do
      plug(Phoenix.LiveView.Flash)
    end

    pipeline :api do
      plug(:accepts, ["json"])
    end

    scope "/", Flames do
      pipe_through(:browser)
      pipe_through(:live)

      get("/", Flames.Live.Default)
      get("/errors/websocket", Flames.Live.Errors)
      get("/socket/websocket", Flames.Live.Errors)
      get("/websocket", Flames.Live.Errors)

    end

    scope "/api", Flames do
      pipe_through(:api)
      pipe_through(:live)
          
      get("/errors/", Flames.Live.Errors)
      get("/errors/:id", Flames.Live.Error)
      delete("/errors/:id", Flames.Live.Error)
      get("/errors/search", Flames.Live.Search)
      
    end
  end
end
