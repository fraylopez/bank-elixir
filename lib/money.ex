defmodule Money do
  @type supported_currencies :: :EUR | :USD

  @type t :: %__MODULE__{
          currency: supported_currencies,
          amount: non_neg_integer
        }

  defstruct currency: :EUR,
            amount: 0

  @spec add(Money.t(), Money.t()) ::
          Money.t() | {:error, :currency_mismatch}
  def add(
        %Money{amount: amount, currency: currency},
        %Money{amount: add_amount, currency: in_currency}
      ) do
    case currency do
      currency when currency == in_currency ->
        {
          :ok,
          %Money{
            currency: currency,
            amount: amount + add_amount
          }
        }

      _ ->
        {:error, :currency_mismatch}
    end
  end

  @spec subtract(Money.t(), Money.t()) ::
          Money.t() | {:error, :currency_mismatch} | {:error, :insufficient_funds}
  def subtract(
        %Money{amount: amount, currency: currency},
        %Money{amount: subtract_amount, currency: in_currency}
      ) do
    case currency do
      currency when currency == in_currency ->
        if amount >= subtract_amount do
          {
            :ok,
            %Money{
              currency: currency,
              amount: amount - subtract_amount
            }
          }
        else
          {:error, :insufficient_funds}
        end

      _ ->
        {:error, :currency_mismatch}
    end
  end
end
