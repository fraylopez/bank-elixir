defmodule BankWeb.BankController do
  use BankWeb, :controller

  def hello(conn, _params) do
    text(conn, "Hello, world!")
  end

  def open(conn, params) do
    currency = params |> Map.get("currency") |> String.to_atom()

    case Bank.Services.open_account(currency) do
      {:ok, id} ->
        json(conn, %{id: id})

      {:error, :invalid_currency} ->
        conn |> put_status(400) |> json(%{error: "Invalid currency"})

      ee ->
        IO.inspect(ee)
        conn |> put_status(500) |> json(%{error: "Internal server error"})
    end
  end
end
