if Code.ensure_loaded?(Phoenix.Socket) do
  defmodule Flames.UserSocket do
    use Phoenix.Socket

    ## Channels
    channel("errors", Flames.ErrorChannel)

    ## Transports
    transport(:websocket, Phoenix.Transports.WebSocket)
    transport(:longpoll, Phoenix.Transports.LongPoll)

    # Socket params are passed from the client and can
    # be used to verify and authenticate a user. After
    # verification, you can put default assigns into
    # the socket that will be set for all channels, ie
    #
    #     {:ok, assign(socket, :user_id, verified_user_id)}
    #
    # To deny connection, return `:error`.
    #
    # See `Phoenix.Token` documentation for examples in
    # performing token verification on connect.
    @endpoint Application.get_env(:flames, :endpoint)
    def connect(%{"token" => token}, socket) do
      # Verify they hit the protected interface
      {:ok, "flames"} = Phoenix.Token.verify(@endpoint, "flames", token)
      {:ok, socket}
    end

    # Socket id's are topics that allow you to identify all sockets for a given user:
    #
    #     def id(socket), do: "users_socket:#{socket.assigns.user_id}"
    #
    # Would allow you to broadcast a "disconnect" event and terminate
    # all active sockets and channels for a given user:
    #
    #     Flames.Endpoint.broadcast("users_socket:" <> user.id, "disconnect", %{})
    #
    # Returning `nil` makes this socket anonymous.
    def id(_socket), do: nil
  end
end
