defmodule Test.Bank.Services do
  use ExUnit.Case
  doctest Bank.Services

  alias Bank.AccountId
  alias Bank.Services
  alias Bank.Account
  alias Test.Support.MoneyMother

  describe "open an account" do
    test "should open an account in a specific currency" do
      account_id = Services.open_account(:USD)
      assert AccountId.is(account_id)
    end
  end
end
