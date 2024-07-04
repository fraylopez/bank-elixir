defmodule Test.Bank.Services do
  use ExUnit.Case
  doctest Bank.Services

  alias Bank.AccountId
  alias Bank.Services
  alias Test.Support.MoneyMother

  describe "open an account" do
    test "should open an account in a specific currency and get its id" do
      account_id = Services.open_account(:USD)
      assert AccountId.is(account_id)
    end
  end

  describe "deposit" do
    setup do
      account_id = Services.open_account(:USD)
      {:ok, account_id: account_id}
    end

    test "should do a deposit", %{account_id: account_id} do
      assert Services.deposit(account_id, MoneyMother.usd(100)) == :ok
    end

    test "should return a currency mismatch error on deposit", %{account_id: account_id} do
      assert {:error, :currency_mismatch} =
               Services.deposit(account_id, MoneyMother.eur(100))
    end
  end

  describe "withdraw" do
    setup do
      account_id = Services.open_account(:USD)
      Services.deposit(account_id, MoneyMother.usd(100))
      {:ok, account_id: account_id}
    end

    test "should do a withdraw", %{account_id: account_id} do
      assert Services.withdraw(account_id, MoneyMother.usd(50)) == :ok
    end

    test "should return a currency mismatch error on withdraw", %{account_id: account_id} do
      assert {:error, :currency_mismatch} =
               Services.withdraw(account_id, MoneyMother.eur(50))
    end

    test "should return an insufficient funds error on withdraw", %{account_id: account_id} do
      assert {:error, :insufficient_funds} =
               Services.withdraw(account_id, MoneyMother.usd(150))
    end
  end
end
