if Code.ensure_loaded?(Phoenix.LiveView) do
  defmodule Flames.Live.Dashboard do
    use Flames.Web, :live_view
    @moduledoc false

    def render(assigns) do
      ~L"""
      <div id="errors" className="table table-stripped table-hover">
  <%=  for x <- @errors do %>
       <%=  live_component(@socket,  ApiWeb.Errors.Detail, error: x) %>
       <% end %>
      </div>
      """
    end

    # def render(assigns), do: Errors.render("index.html", assigns)

    def mount(_session, socket) do
        endpoint = Application.get_env(:flames, :endpoint)
        if connected?(socket), do: endpoint.subscribe("errors", "errors")

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
