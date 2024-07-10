defmodule Test.BankWeb.BankController do
  use ExUnit.Case
  doctest BankWeb.BankController

  import Phoenix.ConnTest

  @endpoint BankWeb.Endpoint

  test "should greet" do
    response =
      build_conn()
      |> get("/")
      |> response(200)

    assert response =~ "Hello, world!"
  end
end
