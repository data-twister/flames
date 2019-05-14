if Code.ensure_loaded?(Phoenix.LiveView) do
  defmodule Flames.Live.None do
    @moduledoc false

    use Phoenix.LiveView

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

    def mount(_session, socket) do
      {:ok, assign(socket, session: nil)}
    end
  end
end
