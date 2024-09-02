defmodule Bank.Accounts.Infrastructure.InMemoryAccountRepository do
  use Agent
  alias Bank.Accounts.Models.AccountId
  alias Bank.Accounts.Models.Account

  def start_link(_) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  @spec find(AccountId.t()) :: {:ok, Account.t()} | :not_found
  def find(id) do
    Agent.get(
      __MODULE__,
      fn accounts ->
        Enum.find(accounts, fn a -> a.id == id end)
        |> case do
          nil -> :not_found
          account -> {:ok, account}
        end
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
