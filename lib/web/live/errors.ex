if Code.ensure_loaded?(Phoenix.LiveView) do
  defmodule Flames.Live.Errors do
    @moduledoc false

    use Phoenix.LiveView

    def render(assigns) do

      ~L"""
      <div>
      <div id="errors" className="table table-stripped table-hover">
      <%= 
      
      Enum.each(@errors, fn(_) -> 
        '<div key={error.id} className={`${this.rowColor(error)} info-row error-row row`} onClick={rowClick}>
        <span className="col-xs-1 level"><span className={`label ${this.levelColor(error)}`}>{error.level}</span></span>
        <span className="col-xs-5 message">{error.message}</span>
        <span className="col-xs-3 file">{this.renderFileInfo(error)}</span>
        <span className="col-xs-1 count">{error.count}</span>
        <span className="col-xs-2 resolve">
          
        </span>
      </div>'
      end)
      %>
      </div>
      </div>
     
      """
    end

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
