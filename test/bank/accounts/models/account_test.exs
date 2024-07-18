defmodule Test.Bank.Accounts.Models.Account do
  use ExUnit.Case
  doctest Bank.Accounts.Models.Account

  alias Test.Support.AccountMother
  alias Test.Support.MoneyMother
  alias Bank.Accounts.Models.Account

  describe "open an account" do
    test "should have 0 balance on open" do
      {:ok, account} = Account.open(:EUR)
      assert Account.balance_of(account) == 0
    end

    test "should have a unique id" do
      {:ok, account1} = Account.open(:EUR)
      {:ok, account2} = Account.open(:EUR)

      refute account1 == account2
    end

    test "should allow opening an account in a specific currency" do
      {:ok, account} = Account.open(:USD)

      assert Account.currency_of(account) == :USD
    end
  end

  describe "deposit" do
    test "should add balance on deposit" do
      {:ok, account} =
        AccountMother.new_eur()
        |> Account.deposit(MoneyMother.eur(100))

      assert Account.balance_of(account) == 100
    end

    test "should prevent deposits with different currencies" do
      account = AccountMother.new_eur()

      assert {:error, :currency_mismatch} =
               Account.deposit(account, MoneyMother.usd(100))
    end
  end

  describe "withdrawals" do
    test "should withdraw balance" do
      {:ok, account} =
        AccountMother.with_balance_eur(100)
        |> Account.withdraw(MoneyMother.eur(50))

      assert Account.balance_of(account) == 50
    end

    test "should prevent withdrawals with different currencies" do
      account = AccountMother.new_eur()

      assert {:error, :currency_mismatch} =
               Account.withdraw(account, MoneyMother.usd(100))
    end

    test "should prevent withdrawals with insufficient funds" do
      account = AccountMother.new_eur()

      assert {:error, :insufficient_funds} =
               Account.withdraw(account, MoneyMother.eur(100))
    end
  end
end
