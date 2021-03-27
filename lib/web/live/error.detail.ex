if Code.ensure_loaded?(Phoenix.LiveView) do
  defmodule Flames.Live.Error.Detail do
    use Flames.Web, :live_component
    @moduledoc false

    # def render(assigns), do: Error.render("index.html", assigns)

    def moduleLine(error) do
      "<span>
      <h5></h5>
      <h6></h6>
    </span>"
    end

    def render(assigns) do
      ~L"""
      <Layout>
      <div className="row">
        <div className="col-xs-12">
          <Link to="/">≪ Back</Link>
        </div>
      </div>
      <div className="row">
        <span>Last occurrence: @error.timestamp</span>
        moduleLine(@error)
        <pre>
        @error.message
        </pre>
      </div>
      </Layout>
      """
    end

    def mount(_session, socket) do
      {:ok, assign(socket, error: "error!")}
    end

  end
end
