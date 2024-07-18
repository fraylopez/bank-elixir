defmodule Bank.Clients.Models.Client do
  alias Bank.Clients.Models.Name
  alias Bank.Clients.Models.CreditScore
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
        first_name: first_name,
        last_name: last_name,
        email: email
      }) do
    %__MODULE__{
      id: ClientId.generate(),
      name: Name.new(first_name, last_name),
      email: Email.new(email),
      credit_score: CreditScore.new()
    }
  end
end
