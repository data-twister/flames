if Code.ensure_loaded?(Phoenix.Router) do
  defmodule Flames.Router do
    @moduledoc """
    """

    use Phoenix.Router

    import Plug.Conn

    import Phoenix.Controller

    import Phoenix.LiveView.Router

    def static_path(%Plug.Conn{script_name: script}, path),
    do: "/" <> Enum.join(script, "/") <> path


    pipeline :browser do
      plug(:accepts, ~w(html json))
      plug(:fetch_session)
      plug(:protect_from_forgery)
      plug(:put_secure_browser_headers)
      plug(:fetch_flash)
      plug(Phoenix.LiveView.Flash)
    end


    scope "/", Flames do
      pipe_through(:browser)

      live("/", Flames.Live.Default)
      live("/errors/websocket", Flames.Live.Errors)
      live("/socket/websocket", Flames.Live.Errors)
      live("/websocket", Flames.Live.Errors)

    end

    scope "/api", Flames do
      pipe_through(:browser)
          
      live("/errors/", Flames.Live.Errors)
      live("/error/:id", Flames.Live.Error)
      live("/errors/search", Flames.Live.Search)
      
    end
  end
end
