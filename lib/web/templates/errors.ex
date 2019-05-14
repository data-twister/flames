if Code.ensure_loaded?(Phoenix.LiveView) do
  defmodule Flames.Template.Errors do
    @moduledoc false

    use Phoenix.LiveView

    def render(assigns) do
      ~L"""
      <div>
      <%= 

      case(Enum.count(@errors) > 0)do 
        true -> '<div id="errors" class="table table-stripped table-hover">
        </div>'
        false -> '<div  id="errors" >
        <div><div className="jumbotron text-center info-row">
      <h1>
      Horray 
      </h1>
      <h4>
      Your application is error free!
      </h4>
      </div>
       
        </div>
      </div>'
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
