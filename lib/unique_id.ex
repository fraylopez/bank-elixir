defmodule UniqueId do
  def generate do
    :crypto.strong_rand_bytes(16) |> Base.encode64()
  end
end
