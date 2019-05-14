defmodule Flames.Endpoint do
  defmacro __using__([]) do
    quote do
      socket("/errors/socket", Flames.UserSocket)
      socket("/errors/websocket", Flames.LiveSocket)
    end
  end
end
