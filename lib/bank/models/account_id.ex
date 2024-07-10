defmodule Bank.Models.AccountId do
  @type t :: String.t()
  def generate do
    :crypto.strong_rand_bytes(16) |> Base.encode64()
  end

  def is(account_id) do
    String.length(account_id) == 24
  end
end
