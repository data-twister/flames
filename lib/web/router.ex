if Code.ensure_loaded?(Phoenix.Router) do
  defmodule Flames.Router do
    @moduledoc """
    """

    use Phoenix.Router
    

    result =  "live-view"

    backend = String.downcase(result)

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

      get("/", ErrorsController, :interface)

      get("/errors/websocket", LiveController, :index)
      get("/socket/websocket", LiveController, :index)
      get("/websocket", LiveController, :index)

    end

    scope "/api", Flames do
      pipe_through(:api)

      case(backend == "react") do
        true ->
          get("/errors/", ErrorsController, :index)
          get("/errors/:id", ErrorsController, :show)
          delete("/errors/:id", ErrorsController, :delete)
          get("/errors/search", ErrorsController, :search)

        false ->
          pipe_through(:live)
          
          get("/errors/", LiveController, :index)
          get("/errors/:id", LiveController, :show)
          delete("/errors/:id", LiveController, :delete)
          get("/errors/search", LiveController, :search)
      end
    end
  end
end
