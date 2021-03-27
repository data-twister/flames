if Code.ensure_loaded?(Phoenix.Router) do
  defmodule Flames.Router do
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
      plug(:fetch_live_flash)
    end

    scope "/", Flames do
      pipe_through(:browser)

      live("/", Live.Errors)
      live("/websocket", Live.Errors)
    end

    scope "/api", Flames do
      pipe_through(:browser)

      live("/errors/", Live.Dashboard)
      live("/error/:id", Live.Error)
    end
  end
end
