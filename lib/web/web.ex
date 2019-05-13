defmodule Flames.Web do
  @moduledoc false

  def view do
    quote do
      use Phoenix.View, root: "lib/web/templates"
      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]

      use Phoenix.HTML

      import Phoenix.LiveView, only: [live_render: 2, live_render: 3]
    end
  end

  def controller do
    quote do
      use Phoenix.Controller
      import Ecto.Query
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  use Plug.Builder

  view = Application.get_env(:flames, :live_view)

  value =
    case view do
      [signing_salt: secret] -> String.trim(secret)
      _ -> nil
    end

  case value do
    nil ->
      plug(Plug.Static, at: "/", from: :flames, only: ~w(css js png))

    "" ->
      plug(Plug.Static, at: "/", from: :flames, only: ~w(css js png))

    "YOUR_SECRET" ->
      plug(Plug.Static, at: "/", from: :flames, only: ~w(css js png))

    _ ->
      plug(Plug.Static, at: "/", from: :flames, only: ~w(css  png))
  end

  # Serves static files, otherwises passes connection to Flames.Router.
  plug(Flames.Router)
end
