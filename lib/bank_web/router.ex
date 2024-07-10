defmodule BankWeb.Router do
  use BankWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", BankWeb do
    pipe_through(:api)

    get("/", BankController, :hello)
  end
end
