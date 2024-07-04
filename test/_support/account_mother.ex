defmodule Test.Support.AccountMother do
  alias Test.Support.MoneyMother
  alias Bank.Account

  def new_eur() do
    Account.open(:EUR)
  end

  def with_balance_eur(balance \\ 100) do
    Account.open(:EUR)
    |> Account.deposit(MoneyMother.eur(balance))
    |> case do
      {:ok, account} -> account
      _ -> raise "Failed to create account with balance"
    end
  end
end
