defmodule Bank.Clients.Models.Name do
  @type t() :: %__MODULE__{
          first_name: String.t(),
          last_name: String.t(),
          middle_name: String.t() | nil
        }

  defstruct first_name: "", last_name: "", middle_name: nil

  def new(first_name, last_name, middle_name \\ nil) do
    %__MODULE__{
      first_name: first_name,
      last_name: last_name,
      middle_name: middle_name
    }
    |> validate()
    |> case do
      {:ok, name} -> name
      {:error, reason} -> {:error, reason}
    end
  end

  def validate(
        %__MODULE__{
          first_name: first_name,
          last_name: last_name,
          middle_name: _middle_name
        } = name
      ) do
    cond do
      String.length(first_name) == 0 -> {:error, :first_name_is_required}
      String.length(last_name) == 0 -> {:error, :last_name_is_required}
      true -> {:ok, name}
    end
  end
end
