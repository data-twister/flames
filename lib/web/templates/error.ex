if Code.ensure_loaded?(Phoenix.LiveView) do
    defmodule Flames.Template.Error do
      @moduledoc false
  
      use Phoenix.LiveView
  
      def render(assigns) do
        ~L"""
        <div>
          <div>
          <%= @error %>
          </div>
        </div>
        """
      end

      def mount(_session, socket) do
        {:ok, assign(socket, error: "error!")}
      end
      
    end

    def handle_event("add-error", %{"q" => error}, socket) do
        case error do
          "" -> {:noreply, assign(socket, :error, "")}
          _  -> {:noreply, assign(socket, :error, error)}
        end
      end
  
    end
  