defmodule Test.Support.AccountMother do
  alias Test.Support.MoneyMother
  alias Bank.Accounts.Models.Account

  def new_eur() do
    {:ok, account} = Account.open(:EUR)
    account
  end

  def with_balance_eur(balance \\ 100) do
    {:ok, account} = Account.open(:EUR)

    account
    |> Account.deposit(MoneyMother.eur(balance))
    |> case do
      {:ok, account} -> account
      _ -> raise "Failed to create account with balance"
    end
  end
end
