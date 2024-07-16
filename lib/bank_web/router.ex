defmodule BankWeb.Router do
  use BankWeb, :router
  use Plug.ErrorHandler

  # fallback error handling
  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", BankWeb do
    pipe_through(:api)

    get("/", BankController, :hello)
    post("/open", BankController, :open)
  end

  @impl Plug.ErrorHandler
  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    send_resp(conn, conn.status, "Something went wrong")
  end
end
