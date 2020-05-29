defmodule Flames.Web do
  @moduledoc false

  use Plug.Builder

  def channel do
    quote do
      use Phoenix.Channel

      import Flames.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/web/templates", namespace: Flames.Web

      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]

unquote(view_helpers())
    end
  end

  def controller do
    quote do
      use Phoenix.Controller, namespace: Flames.Web

      import Plug.Conn

      import Flames.Gettext

      alias Flames.Router.Helpers, as: Routes

      import Ecto.Query
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

    def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(view_helpers())
    end
  end

    def live_view do
    quote do
      use Phoenix.LiveView

      unquote(view_helpers())

    end
  end

  def view_helpers do
    quote do
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import Phoenix.LiveView

      import Flames.ErrorHelpers

      import Flames.Gettext

      alias Flames.Router.Helpers, as: Routes
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
 

  plug(Flames.Router)
end
