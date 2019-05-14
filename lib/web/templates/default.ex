if Code.ensure_loaded?(Phoenix.LiveView) do
  defmodule Flames.Template.Default do
    @moduledoc false

    use Phoenix.LiveView

    def render(assigns) do
      ~L"""
      <div>
        <div>
        <div className="jumbotron text-center info-row">
      <h1>
      Loading ...
      </h1>
      
      </div>
       
        </div>
      </div>
      """
    end

    def mount(_session, socket) do
      {:ok, assign(socket, session: nil)}
    end
  end
end
