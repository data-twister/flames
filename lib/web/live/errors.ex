if Code.ensure_loaded?(Phoenix.LiveView) do
  defmodule Flames.Live.Errors do
    @moduledoc false

    use Phoenix.LiveView

    def levelColor(error) do
      nil
    end

    def renderFileInfo(error) do
      nil
    end

    def rowColor(error) do
      nil
    end

    def render(assigns) do
      ~L"""
      <div>
      <div id="errors" className="table table-stripped table-hover">
      </div>
      </div>

      """
    end

    # def render(assigns), do: Errors.render("index.html", assigns)

    def mount(_session, socket) do
      {:ok, assign(socket, errors: [])}
    end

    def handle_event("add-errors", %{"q" => errors}, socket) do
      case errors do
        "" -> {:noreply, assign(socket, :errors, [])}
        _ -> {:noreply, assign(socket, :errors, errors)}
      end
    end
  end
end
