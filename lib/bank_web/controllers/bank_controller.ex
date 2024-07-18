defmodule BankWeb.BankController do
  use BankWeb, :controller

  def hello(conn, _params) do
    text(conn, "Hello, world!")
  end

  def open(conn, params) do
    with {:ok, currency} <- maybe_get_currency(params),
         {:ok, id} <- Bank.Services.open_account(currency) do
      json(conn, %{id: id})
    else
      {:error, :invalid_currency} ->
        conn |> put_status(400) |> json(%{error: "Invalid currency"})

      {:error, :missing_currency} ->
        conn |> put_status(400) |> json(%{error: "Missing currency"})

      _ ->
        conn |> put_status(500) |> json(%{error: "Internal server error"})
    end
  end

  defp maybe_get_currency(params) do
    case Map.get(params, "currency") do
      nil -> {:error, :missing_currency}
      currency -> {:ok, String.to_atom(currency)}
    end
  end
end
