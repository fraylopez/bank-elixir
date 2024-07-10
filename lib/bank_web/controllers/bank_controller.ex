defmodule BankWeb.BankController do
  use BankWeb, :controller

  def hello(conn, _params) do
    text(conn, "Hello, world!")
  end

  def open(_conn, _params) do
    IO.puts("Opening account")
  end
end
