if Code.ensure_loaded?(Phoenix.View) && Code.ensure_loaded?(Phoenix.HTML) do
  defmodule Flames.LiveView do
    @moduledoc false

    use Flames.Web, :view
  end
end
