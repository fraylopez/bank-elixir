defmodule Bank.Services do
  alias Bank.Money
  alias Bank.AccountId
  alias Bank.Account

  @account_repository Application.compile_env!(:bank, :account_repository)

  @spec open_account(Money.supported_currencies()) :: AccountId.t()
  def open_account(currency) do
    account = Account.open(currency)
    @account_repository.save(account)
    account.id
  end
end
