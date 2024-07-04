defmodule Test.Bank.Account do
  use ExUnit.Case
  doctest Bank.Account

  alias Bank.Account
  alias Test.Support.MoneyMother

  describe "open an account" do
    test "should have 0 balance on open" do
      assert Account.balance_of(Account.open()) == 0
    end

    test "should have a unique id" do
      account1 = Account.open()
      account2 = Account.open()
      refute account1 == account2
    end

    test "should allow opening an account in a specific currency" do
      account = Account.open(:USD)

      assert Account.currency_of(account) == :USD
    end
  end

  describe "deposit" do
    test "should add balance on deposit" do
      account =
        Account.open()
        |> Account.deposit(MoneyMother.eur(100))

      assert Account.balance_of(account) == 100
    end

    test "should prevent deposits with different currencies" do
      account = Account.open(:EUR)

      assert {:error, :currency_mismatch} =
               Account.deposit(account, MoneyMother.usd(100))
    end
  end

  describe "withdrawals" do
    test "should withdraw balance" do
      account =
        Account.open()
        |> Account.deposit(MoneyMother.eur(100))
        |> Account.withdraw(MoneyMother.eur(50))

      assert Account.balance_of(account) == 50
    end

    test "should prevent withdrawals with different currencies" do
      account = Account.open(:EUR)

      assert {:error, :currency_mismatch} =
               Account.withdraw(account, MoneyMother.usd(100))
    end

    test "should prevent withdrawals with insufficient funds" do
      account = Account.open()

      assert {:error, :insufficient_funds} =
               Account.withdraw(account, MoneyMother.eur(100))
    end
  end
end
