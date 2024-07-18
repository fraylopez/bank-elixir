defmodule Test.BankWeb.BankController do
  use ExUnit.Case
  doctest BankWeb.BankController

  alias Bank.Accounts.Models.AccountId
  import Phoenix.ConnTest

  @endpoint BankWeb.Endpoint

  test "should greet" do
    response =
      build_conn()
      |> get("/")
      |> response(200)

    assert response =~ "Hello, world!"
  end

  test "should open an account" do
    response =
      build_conn()
      |> post("/open", %{"currency" => "EUR"})
      |> json_response(200)

    assert AccountId.is(response["id"])
  end

  test "should return 400 if currency is not valid" do
    response =
      build_conn()
      |> post("/open", %{"currency" => "INVALID"})
      |> json_response(400)

    assert response["error"] == "Invalid currency"
  end

  test "should return 400 if currency is missing" do
    response =
      build_conn()
      |> post("/open", %{})
      |> json_response(400)

    assert response["error"] == "Missing currency"
  end
end
