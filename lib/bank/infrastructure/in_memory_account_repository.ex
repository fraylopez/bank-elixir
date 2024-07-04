defmodule Bank.Infrastructure.InMemoryAccountRepository do
  use Agent
  alias Bank.AccountId
  alias Bank.Account

  def start_link(_) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  @spec find(AccountId.t()) :: Account.t() | nil
  def find(id) do
    Agent.get(
      __MODULE__,
      fn accounts ->
        Enum.find(accounts, fn a -> a.id == id end)
      end
    )
  end

  @spec save(Account.t()) :: :ok
  def save(account) do
    Agent.update(
      __MODULE__,
      fn accounts ->
        Enum.filter(accounts, fn a -> a.id != account.id end) ++ [account]
      end
    )
  end
end
