defmodule Test.Support.MoneyMother do
  alias Bank.Accounts.Models.Money

  def eur(amount) do
    %Money{amount: amount, currency: :EUR}
  end

  def usd(amount) do
    %Money{amount: amount, currency: :USD}
  end
end
