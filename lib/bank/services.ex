defmodule Bank.Services do
  alias Bank.Models.Money
  alias Bank.Models.AccountId
  alias Bank.Models.Account

  @account_repository Application.compile_env!(:bank, :account_repository)

  @spec open_account(Money.supported_currencies()) :: {:ok, AccountId.t()} | {:error, term()}
  def open_account(currency) do
    case Account.open(currency) do
      {:ok, account} ->
        @account_repository.save(account)
        {:ok, account.id}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @spec deposit(AccountId.t(), Money.t()) :: :ok | {:error, :currency_mismatch}
  def deposit(account_id, money) do
    account = @account_repository.find(account_id)

    case Account.deposit(account, money) do
      {:ok, account} ->
        @account_repository.save(account)

      {:error, :currency_mismatch} ->
        {:error, :currency_mismatch}
    end
  end

  @spec withdraw(AccountId.t(), Money.t()) ::
          :ok | {:error, :currency_mismatch} | {:error, :insufficient_funds}
  def withdraw(account_id, money) do
    account = @account_repository.find(account_id)

    case Account.withdraw(account, money) do
      {:ok, account} ->
        @account_repository.save(account)

      {:error, :currency_mismatch} ->
        {:error, :currency_mismatch}

      {:error, :insufficient_funds} ->
        {:error, :insufficient_funds}
    end
  end
end
