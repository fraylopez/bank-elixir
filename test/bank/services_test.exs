defmodule Test.Bank.Services do
  use ExUnit.Case
  doctest Bank.Services

  alias Bank.AccountId
  alias Bank.Services
  alias Bank.Account
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
end
