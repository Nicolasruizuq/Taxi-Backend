defmodule TaxisWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :taxis

  plug CORSPlug, origin: ["http://localhost:8080"]

  plug Plug.Static,
    at: "/",
    from: :taxis,
    gzip: false,
    only: ~w(assets fonts images favicon.ico robots.txt)

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  plug TaxisWeb.Router
end
