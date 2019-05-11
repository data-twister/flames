if Code.ensure_loaded?(Phoenix.Router) do
  defmodule Flames.Router do
    @moduledoc """
    """

    use Phoenix.Router

    def static_path(%Plug.Conn{script_name: script}, path), do: "/" <> Enum.join(script, "/") <> path

    pipeline :browser do
      plug :accepts, ~w(html)
      plug :fetch_flash
    end

    pipeline :live do
      plug Phoenix.LiveView.Flash
    end

    pipeline :api do
      plug :accepts, ["json"]
    end

    scope "/", Flames do
      pipe_through :browser
      pipe_through :live

      get "/", ErrorsController, :interface
    end

    scope "/api", Flames do
      pipe_through :api

      get "/errors", ErrorsController, :index
      get "/errors/:id", ErrorsController, :show
      delete "/errors/:id", ErrorsController, :delete
      get "/errors/search", ErrorsController, :search
    end
  end

  scope "/api/live", Flames do
    pipe_through :api

    get "/errors", ErrorsController, :live_index
    get "/errors/:id", ErrorsController, :live_show
    delete "/errors/:id", ErrorsController, :live_delete
    get "/errors/search", ErrorsController, :live_search
  end
end
end
