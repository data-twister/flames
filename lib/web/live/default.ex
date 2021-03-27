if Code.ensure_loaded?(Phoenix.LiveView) do
  defmodule Flames.Live.Default do
    use Flames.Web, :live_view
    @moduledoc false

    def render(assigns) do
      ~L"""
      <div className="jumbotron text-center info-row">
      <h1>
      Loading ...
      </h1>
      </div>
      """
    end

    # def render(assigns), do: Default.render("index.html", assigns)

    def mount(_session, socket) do
      {:ok, assign(socket, session: nil)}
    end
  end
end
