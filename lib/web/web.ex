defmodule Flames.Web do

   @moduledoc false

   def channel do
    quote do
      use Phoenix.Channel
    end
  end

   def view do
    quote do
      use Phoenix.View, root: "lib/web/templates"
     
      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]

      use Phoenix.HTML

      import Phoenix.LiveView, only: [live_render: 2, live_render: 3]

      alias Flames.Router.Helpers, as: Routes
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      alias Flames.Router.Helpers, as: Routes

      import Ecto.Query
    end
  end


  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  # Serves static files, otherwises passes connection to Flames.Router.
  use Plug.Builder

  plug(Plug.Static, at: "/", from: :flames, only: ~w(css js png))

  plug(Flames.Router)
end
