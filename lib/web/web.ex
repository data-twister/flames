defmodule Flames.Web do
  @moduledoc false

  def view do
    quote do
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
     
      import Phoenix.LiveView.Router
    end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

end
