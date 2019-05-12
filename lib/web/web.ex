defmodule Flames.Web do
  @moduledoc false

  def view do
    quote do
      use Phoenix.View, root: "lib/web/templates"
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
     
      import Phoenix.LiveView.Router
    end
    end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  use Plug.Builder

  [signing_salt: secret] = Application.get_env(:flames, :live_view)

  case String.trim(secret) do
    nil -> nil
    "" -> nil
    "YOUR_SECRET" -> nil
    _ ->  
      plug Plug.Static,
    at: "/", from: :flames,
    only: ~w(css js png)
  end

  # Serves static files, otherwises passes connection to Flames.Router.
  plug Flames.Router


 

end

