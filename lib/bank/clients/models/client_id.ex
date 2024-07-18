defmodule Bank.Clients.Models.ClientId do
  @type t :: String.t()
  def generate do
    :crypto.strong_rand_bytes(16) |> Base.encode64()
  end

  def is(id) do
    String.length(id) == 24
  end
end
