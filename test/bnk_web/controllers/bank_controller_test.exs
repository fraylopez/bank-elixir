defmodule Test.BankWeb.BankController do
  use ExUnit.Case
  doctest BankWeb.BankController

  import Phoenix.ConnTest

  @endpoint BankWeb.Endpoint

  test "hello" do
    build_conn()
    |> get("/")
    |> response(200)
  end
end
