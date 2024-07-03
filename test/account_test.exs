defmodule AccountTest do
  use ExUnit.Case
  doctest Account

  alias Test.Support.MoneyMother

  test "should have 0 balance on open" do
    assert Account.balance_of(Account.open()) == 0
  end

  test "should have a unique id" do
    account1 = Account.open()
    account2 = Account.open()
    refute account1 == account2
  end

  test "should add balance on deposit" do
    account =
      Account.open()
      |> Account.deposit(MoneyMother.eur(100))

    assert Account.balance_of(account) == 100
  end

  test "should prevent deposits with different currencies" do
    account =
      Account.open()
      |> Account.deposit(MoneyMother.eur(100))

    assert {:error, :currency_mismatch} =
             Account.deposit(account, %Money{amount: 100, currency: :USD})
  end
end