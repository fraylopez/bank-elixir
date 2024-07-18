defmodule Bank.Accounts.Models.Account do
  @type t :: %__MODULE__{
          id: AccountId.t(),
          balance: Money.t()
        }
  defstruct id: "",
            balance: 0

  alias Bank.Accounts.Models.AccountId
  alias Bank.Accounts.Models.Money
  alias Bank.Accounts.Models.Currency

  @spec open(Currency.t()) :: {:ok, Bank.Models.Account.t()} | {:error, :invalid_currency}

  def open(currency) do
    if Currency.supported?(currency) do
      {:ok,
       %__MODULE__{
         id: AccountId.generate(),
         balance: %Money{
           currency: currency
         }
       }}
    else
      {:error, :invalid_currency}
    end
  end

  def balance_of(%__MODULE__{balance: balance}), do: balance.amount

  def currency_of(%__MODULE__{balance: balance}), do: balance.currency

  @spec deposit(t(), Money.t()) :: {:ok, t()} | {:error, :currency_mismatch}
  def deposit(account, amount) do
    case Money.add(account.balance, amount) do
      {:ok, updated_balance} -> {:ok, update_balance(account, updated_balance)}
      {:error, :currency_mismatch} -> {:error, :currency_mismatch}
    end
  end

  @spec withdraw(t(), Money.t()) ::
          {:ok, t()} | {:error, :currency_mismatch} | {:error, :insufficient_funds}
  def withdraw(account, amount) do
    case Money.subtract(account.balance, amount) do
      {:ok, updated_balance} when account.balance >= amount ->
        {:ok, update_balance(account, updated_balance)}

      {:ok, _updated_balance} ->
        {:error, :insufficient_funds}

      {:error, :currency_mismatch} ->
        {:error, :currency_mismatch}
    end
  end

  defp update_balance(account, balance) do
    %__MODULE__{
      account
      | balance: balance
    }
  end
end
