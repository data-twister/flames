if Code.ensure_loaded?(Phoenix.LiveView) do
    defmodule Flames.Template.Index do
      @moduledoc false
  
      use Phoenix.LiveView
  
      def render(assigns) do
        ~L"""
        <div class="">
          <div>
            index
          </div>
        </div>
        """
      end
  
    end
    end
  