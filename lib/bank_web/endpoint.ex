defmodule BankWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :bank

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason
  )

  plug(BankWeb.Router)
end
