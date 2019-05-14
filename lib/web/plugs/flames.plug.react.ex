defmodule Flames.Plug.React do
    @moduledoc """
    Puts  into conn.assigns[:x-application-provider] if there is none  puts liveview
    """
  
    @spec init(Keyword.t) :: Keyword.t
    def init(opts), do: opts
  
    @spec call(Plug.Conn.t, Keyword.t) :: Plug.Conn.t
    def call(conn, _opts) do
        Plug.Conn.assign(conn, "x-application-provider", "live-view")
   conn
  end
  end
  