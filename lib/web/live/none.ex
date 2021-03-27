if Code.ensure_loaded?(Phoenix.LiveView) do
  defmodule Flames.Live.None do
    use Flames.Web, :live_view
    @moduledoc false

    def render(assigns) do
      ~L"""
      <div className="jumbotron text-center info-row">
      <h1>
      Hooray!
      </h1>
      <h4>
        Your application is error free!
      </h4>
      </div>
      """
    end

    # def render(assigns), do: None.render("index.html", assigns)

    def mount(_session, socket) do
      {:ok, assign(socket, session: nil)}
    end
  end
end
