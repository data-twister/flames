if Code.ensure_loaded?(Phoenix.Controller) do
  defmodule Flames.LiveController do
    @moduledoc false

    use Flames.Web, :controller
    alias Phoenix.LiveView

    def interface(conn, _) do
      render(conn, "app.html")
    end

    def index(conn, _) do
      repo = Application.get_env(:flames, :repo)
      errors = repo.all(from(e in Flames.Error, order_by: [desc: e.id]))

      case Enum.count(errors) > 1 do
        true -> LiveView.Controller.live_render(conn, Flames.Live.Errors, session: errors)
        false -> LiveView.Controller.live_render(conn, Flames.Live.None, session: [])
      end
    end

    def show(conn, %{"id" => error_id}) do
      repo = Application.get_env(:flames, :repo)
      error = repo.one(from(e in Flames.Error, where: e.id == ^error_id, limit: 1))

      case Enum.count(error) > 1 do
        true -> LiveView.Controller.live_render(conn, Flames.Live.Error, session: error)
        false -> LiveView.Controller.live_render(conn, Flames.Live.None, session: [])
      end
    end

    def search(conn, %{"term" => term}) do
      # TODO: Finish
      results = term |> String.split(" ")

      case Enum.count(results) > 1 do
        true -> LiveView.Controller.live_render(conn, Flames.Live.Errors, session: results)
        false -> LiveView.Controller.live_render(conn, Flames.Live.None, session: [])
      end
    end

    def delete(conn, %{"id" => error_id}) do
      repo = Application.get_env(:flames, :repo)
      error = repo.get!(Flames.Error, error_id)

      changeset = Flames.Error.changeset(error, %{resolved: true})
      repo.update!(changeset)

      send_resp(conn, :no_content, "")
    end
  end
end
