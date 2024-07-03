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

  @spec deposit(Account.t(), Money.t()) :: Account.t()
  def deposit(account, amount) do
    case Money.add(account.balance, amount) do
      {:ok, updated_balance} -> update_balance(account, updated_balance)
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
