defmodule Money do
  @supported_currencies [:EUR, :USD]

  @type t :: %__MODULE__{
          currency: supported_currencies,
          amount: non_neg_integer
        }

  @type supported_currencies ::
          unquote(
            @supported_currencies
            |> Enum.map(&inspect/1)
            |> Enum.join(" | ")
            |> Code.string_to_quoted!()
          )

  defstruct currency: :EUR,
            amount: 0

  @spec add(Money.t(), Money.t()) :: {:ok, Money.t()} | {:error, :currency_mismatch}
  def add(
        %Money{amount: base_amount, currency: base_currency},
        %Money{amount: add_amount, currency: add_currency}
      ) do
    case validate_currency(base_currency, add_currency) do
      {:valid_currency, true} ->
        {:ok,
         %Money{
           currency: base_currency,
           amount: base_amount + add_amount
         }}

      {:valid_currency, {:error, :currency_mismatch}} ->
        {:error, :currency_mismatch}
    end
  end

  @spec subtract(Money.t(), Money.t()) ::
          {:ok, Money.t()} | {:error, :currency_mismatch} | {:error, :insufficient_funds}
  def subtract(
        %Money{amount: base_amount, currency: base_currency},
        %Money{amount: substract_amount, currency: substract_currency}
      ) do
    with true <- base_amount >= substract_amount,
         {:valid_currency, true} <- validate_currency(base_currency, substract_currency) do
      {:ok,
       %Money{
         currency: base_currency,
         amount: base_amount - substract_amount
       }}
    else
      false -> {:error, :insufficient_funds}
      {:valid_currency, false} -> {:error, :currency_mismatch}
    end
  end

  defp validate_currency(currency_1, currency_2) when currency_1 == currency_2,
    do: {:valid_currency, true}

  defp validate_currency(_, _), do: {:valid_currency, {:error, :currency_mismatch}}
end
