import LiveSocket from "phoenix_live_view"

let liveSocket = new LiveSocket("/errors")
liveSocket.connect()