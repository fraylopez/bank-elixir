defmodule Account do
  @type t :: %__MODULE__{
          id: String.t(),
          balance: Money.t()
        }
  defstruct id: "",
            balance: 0

  def open(currency \\ :EUR) do
    %Account{
      id: UniqueId.generate(),
      balance: %Money{
        currency: currency
      }
    }
  end

  def balance_of(%Account{balance: balance}), do: balance.amount

  def currency_of(%Account{balance: balance}), do: balance.currency

  @spec deposit(Account.t(), Money.t()) :: Account.t() | {:error, :currency_mismatch}
  def deposit(account, amount) do
    case Money.add(account.balance, amount) do
      {:ok, updated_balance} -> update_balance(account, updated_balance)
      {:error, :currency_mismatch} -> {:error, :currency_mismatch}
    end
  end

  @spec withdraw(Account.t(), Money.t()) ::
          Account.t() | {:error, :currency_mismatch} | {:error, :insufficient_funds}
  def withdraw(account, amount) do
    case Money.subtract(account.balance, amount) do
      {:ok, updated_balance} -> update_balance(account, updated_balance)
      {:error, :insufficient_funds} -> {:error, :insufficient_funds}
      {:error, :currency_mismatch} -> {:error, :currency_mismatch}
    end
  end

  defp update_balance(account, balance) do
    %Account{
      account
      | balance: balance
    }
  end
end
