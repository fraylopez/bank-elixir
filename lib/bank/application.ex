defmodule Bank.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      Bank.Accounts.Infrastructure.InMemoryAccountRepository,
      BankWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Bank.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
