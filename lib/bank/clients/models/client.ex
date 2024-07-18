defmodule Bank.Clients.Models.Client do
  alias Bank.Clients.Models.Client.Name
  alias Bank.Clients.Models.Client.CreditScore
  alias Bank.Clients.Models.Email
  alias Bank.Clients.Models.ClientId

  @type t() :: %__MODULE__{
          id: UserId.t(),
          name: Name.t(),
          email: Email.t(),
          credit_score: CreditScore.t()
        }

  defstruct id: nil, name: nil, email: nil, credit_score: 100

  def new(%{
        name: name,
        last_name: last_name,
        email: email
      }) do
    %__MODULE__{
      id: ClientId.generate(),
      name: Name.new(name, last_name),
      email: Email.new(email),
      credit_score: CreditScore.new()
    }
  end
end

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

defmodule Bank.Clients.Models.Client.Name do
  @type t() :: %__MODULE__{
          name: String.t(),
          last_name: String.t(),
          middle_name: String.t() | nil
        }

  defstruct name: nil, last_name: nil, middle_name: nil

  def new(name, last_name, middle_name \\ nil) do
    %__MODULE__{
      name: name,
      last_name: last_name,
      middle_name: middle_name
    }
  end
end

defmodule Bank.Clients.Models.Client.CreditScore do
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
