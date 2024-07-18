defmodule Bank.Clients.Models.Email do
  @type t() :: %__MODULE__{
          address: String.t()
        }

  defstruct address: nil

  def new(address) do
    %__MODULE__{
      address: address
    }
  end
end
