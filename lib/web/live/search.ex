if Code.ensure_loaded?(Phoenix.LiveView) do
    defmodule Flames.Live.Search do
      @moduledoc false
  
      use Phoenix.LiveView
  
      def render(assigns) do
        ~L"""
        <form className="navbar-form navbar-right" role="search">
              <div className="form-group">
                <input type="text" className="form-control" placeholder="Search"   />
              </div>
            </form>
        """
      end

          # def render(assigns), do: Search.render("index.html", assigns)
  
      def mount(_session, socket) do
        {:ok, assign(socket, session: nil)}
      end
    end
  end
  