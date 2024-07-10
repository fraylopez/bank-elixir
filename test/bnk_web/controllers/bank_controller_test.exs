defmodule Test.BankWeb.BankController do
  use ExUnit.Case
  doctest BankWeb.BankController

  import Phoenix.ConnTest

  @endpoint BankWeb.Endpoint

  setup do
    conn = build_conn()
    {:ok, conn: conn}
  end

  test "hello", %{
    conn: conn
  } do
    conn
    |> get("/")
    |> response(200)
  end
end
