if Code.ensure_loaded?(Phoenix.LiveView) do
  defmodule Flames.Template.Free do
    @moduledoc false

    use Phoenix.LiveView

    def render(assigns) do
      ~L"""
      <div>
        <div>
        <div className="jumbotron text-center info-row">
      <h1>
      <%= @session.title %>
      </h1>
      <h4>
      <%= @session.data %>
      </h4>
      </div>
       
        </div>
      </div>
      """
    end

    def mount(_session, socket) do
      {:ok, assign(socket, session: %{title: "&nbsp;Hooray!&nbsp;", data: "Your application is error free!"})}
    end
  end
end
