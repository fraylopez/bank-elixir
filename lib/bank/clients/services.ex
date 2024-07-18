defmodule Bank.Clients.Services do
  alias Bank.Clients.Models.Client

  def create_client(name, last_name, email) do
    client = Client.new(%{name: name, last_name: last_name, email: email})
    {:ok, client.id}
  end
end
