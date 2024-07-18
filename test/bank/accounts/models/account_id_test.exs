defmodule Test.Bank.Accounts.Models.AccountId do
  use ExUnit.Case

  alias Bank.Accounts.Models.AccountId

  describe "is" do
    test "should return true if the account id is valid" do
      assert AccountId.is(AccountId.generate())
    end

    test "should return false if the account id is invalid" do
      assert !AccountId.is("invalid")
    end
  end
end
