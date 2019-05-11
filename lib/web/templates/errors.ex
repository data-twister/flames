if Code.ensure_loaded?(Phoenix.LiveView) do
    defmodule Flames.Template.Errors do
      @moduledoc false
  
      use Phoenix.LiveView
  
      def render(assigns) do
        ~L"""
        <div class="">
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
  
    end
  