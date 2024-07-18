defmodule Bank.Clients.ServicesTest do
  use ExUnit.Case

  alias Bank.Clients.Models.ClientId
  alias Bank.Clients.Services

  test "create_client/1" do
    {:ok, client_id} = Services.create_client("John", "Doe", "john.doe@example.com")
    assert ClientId.is(client_id)
  end
end
