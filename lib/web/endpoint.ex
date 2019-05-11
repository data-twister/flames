defmodule Flames.Endpoint do
  defmacro __using__([]) do
    quote do
    
    socket "/errors/socket", Flames.UserSocket
    socket "/errors/live", Phoenix.LiveView.Socket

  end
  end
  end
  