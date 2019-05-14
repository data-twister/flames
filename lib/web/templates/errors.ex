if Code.ensure_loaded?(Phoenix.LiveView) do
  defmodule Flames.Template.Errors do
    @moduledoc false

    use Phoenix.LiveView

    def render(assigns) do
      ~L"""
      <div>
      <%= 
      case(Enum.count(@errors) > 0)do 
        true -> <div id="errors" class="table table-stripped table-hover">
        <%= Enum.each(@errors, fn(error) -> 
          el = '<div key=id clas="info-row error-row row" >
          <span className="col-xs-1 level"><span class="label"}>level</span></span>
          <span className="col-xs-5 message">message</span>
          <span className="col-xs-3 file"></span>
          <span className="col-xs-1 count">4</span>
          <span className="col-xs-2 resolve">
            
          </span>
        </div>'
          el
        end)
        %>
        </div>
        false -> <div>
        <div>
        <div className="jumbotron text-center info-row">
      <h1>
      Horray 
      </h1>
      <h4>
      Your application is error free!
      </h4>
      </div>
       
        </div>
      </div>
      end)
      %>
        
      </div>
      """
    end

    def mount(_session, socket) do
      {:ok, assign(socket, errors: [], )}
    end

    def handle_event("add-errors", %{"q" => errors}, socket) do
      case errors do
        "" -> {:noreply, assign(socket, :errors, [])}
        _ -> {:noreply, assign(socket, :errors, errors)}
      end
    end
  end
end
