defmodule Bank.Accounts.Models.Money do
  alias Bank.Accounts.Models.Currency

  @type t :: %__MODULE__{
          currency: Currency.supported_currencies(),
          amount: non_neg_integer
        }

  defstruct currency: :EUR,
            amount: 0

  @spec add(t(), t()) :: {:ok, t()} | {:error, :currency_mismatch}
  def add(
        %__MODULE__{amount: base_amount, currency: base_currency},
        %__MODULE__{amount: add_amount, currency: add_currency}
      ) do
    case validate_currency(base_currency, add_currency) do
      {:valid_currency, true} ->
        {:ok,
         %__MODULE__{
           currency: base_currency,
           amount: base_amount + add_amount
         }}

      {:valid_currency, {:error, :currency_mismatch}} ->
        {:error, :currency_mismatch}
    end
  end

  @spec subtract(t(), t()) ::
          {:ok, t()} | {:error, :currency_mismatch} | {:error, :insufficient_funds}
  def subtract(
        %__MODULE__{amount: base_amount, currency: base_currency},
        %__MODULE__{amount: substract_amount, currency: substract_currency}
      ) do
    case validate_currency(base_currency, substract_currency) do
      {:valid_currency, true} ->
        {:ok,
         %__MODULE__{
           currency: base_currency,
           amount: base_amount - substract_amount
         }}

      {:valid_currency, {:error, :currency_mismatch}} ->
        {:error, :currency_mismatch}
    end
  end

  defp validate_currency(currency_1, currency_2) when currency_1 == currency_2,
    do: {:valid_currency, true}

  defp validate_currency(_, _), do: {:valid_currency, {:error, :currency_mismatch}}
end
