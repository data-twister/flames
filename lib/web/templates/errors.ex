if Code.ensure_loaded?(Phoenix.LiveView) do
    defmodule Flames.Template.Errors do
      @moduledoc false
  
      use Phoenix.LiveView
  
      def render(assigns) do
        ~L"""
        <div>
          <div>
          <%= @errors %>
          </div>
        </div>
        """
      end

      def mount(_session, socket) do
        {:ok, assign(socket, errors: "error!")}
      end
    end

    def handle_event("add-errors", %{"q" => errors}, socket) do
      case errors do
        "" -> {:noreply, assign(socket, :errors, "")}
        _  -> {:noreply, assign(socket, :errors, errors)}
      end
    end

    end
  