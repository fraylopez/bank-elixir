defmodule Bank.Clients.Models.CreditScore do
  @type t() :: %__MODULE__{
          score: non_neg_integer()
        }

  defstruct score: 100

  def new() do
    %__MODULE__{
      score: 100
    }
  end
end
