if Code.ensure_loaded?(Phoenix.LiveView) do
  defmodule Flames.Template.Index do
    @moduledoc false

    use Phoenix.LiveView

    def render(assigns) do
      ~L"""
      <div class="">
        <div>
        <%= @data %>
        </div>
      </div>
      """
    end

    def mount(_session, socket) do
      {:ok, assign(socket, data: "error!")}
    end
  end
end
