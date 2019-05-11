defmodule Flames.Endpoint do
    use Phoenix.Endpoint
    
    socket "/errors/socket", Flames.UserSocket
    socket "/errors/live", Phoenix.LiveView.Socket

  end
  