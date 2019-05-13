if Code.ensure_loaded?(Phoenix.Controller) do
  defmodule Flames.ErrorsController do
    @moduledoc false

    use Flames.Web, :controller
    alias Phoenix.LiveView

    def interface(conn, _) do
      repo = Application.get_env(:flames, :repo)
      errors = repo.all(from(e in Flames.Error, order_by: [desc: e.id]))
      LiveView.Controller.live_render(conn, Flames.Template.Index, session: errors)
    end

    def live_index(conn, _) do
      repo = Application.get_env(:flames, :repo)
      errors = repo.all(from(e in Flames.Error, order_by: [desc: e.id]))
      LiveView.Controller.live_render(conn, Flames.Template.Errors, session: errors)
    end

    def live_show(conn, %{"id" => error_id}) do
      repo = Application.get_env(:flames, :repo)
      error = repo.one(from(e in Flames.Error, where: e.id == ^error_id, limit: 1))
      LiveView.Controller.live_render(conn, Flames.Template.Errors, session: error)
    end

    def live_search(conn, %{"term" => term}) do
      # TODO: Finish
      results = term |> String.split(" ")
      LiveView.Controller.live_render(conn, Flames.Template.Errors, session: results)
    end

    def index(conn, _params) do
      repo = Application.get_env(:flames, :repo)
      errors = repo.all(from(e in Flames.Error, order_by: [desc: e.id]))
      render(conn, "index.json", errors: errors)
    end

    def show(conn, %{"id" => error_id}) do
      repo = Application.get_env(:flames, :repo)
      error = repo.one(from(e in Flames.Error, where: e.id == ^error_id, limit: 1))
      render(conn, "show.json", error: error)
    end

    def delete(conn, %{"id" => error_id}) do
      repo = Application.get_env(:flames, :repo)
      error = repo.get!(Flames.Error, error_id)

      changeset = Flames.Error.changeset(error, %{resolved: true})
      repo.update!(changeset)

      send_resp(conn, :no_content, "")
    end

    def search(conn, %{"term" => term}) do
      # TODO: Finish
      results = term |> String.split(" ")
      conn |> json(%{results: results})
    end
  end
end
