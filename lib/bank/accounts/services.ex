defmodule Bank.Accounts.Services do
  alias Bank.Accounts.Models.Money
  alias Bank.Accounts.Models.AccountId
  alias Bank.Accounts.Models.Account

  @account_repository Application.compile_env!(:bank, :account_repository)

  @spec open_account(Money.supported_currencies()) :: {:ok, AccountId.t()} | {:error, term()}
  def open_account(currency) do
    with {:ok, account} <- Account.open(currency),
         :ok <- @account_repository.save(account) do
      {:ok, account.id}
    end
  end

  @spec deposit(AccountId.t(), Money.t()) :: :ok | {:error, :currency_mismatch}
  def deposit(account_id, money) do
    # move this to a with statement
    # account = @account_repository.find(account_id)

    with {:ok, account} <- @account_repository.find(account_id),
         {:ok, account} <- Account.deposit(account, money) do
      @account_repository.save(account)
    end
  end

  @spec withdraw(AccountId.t(), Money.t()) ::
          :ok | {:error, :currency_mismatch} | {:error, :insufficient_funds}
  def withdraw(account_id, money) do
    with {:ok, account} <- @account_repository.find(account_id),
         {:ok, account} <- Account.withdraw(account, money) do
      @account_repository.save(account)
    end
  end
end
