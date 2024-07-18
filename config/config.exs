import Config

config :phoenix, :json_library, Jason

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :bank, BankWeb.Endpoint,
  http: [
    port: System.get_env("PORT", "8080") |> String.to_integer()
  ]

config :bank, :account_repository, Bank.Accounts.Infrastructure.InMemoryAccountRepository

import_config("#{Mix.env()}.exs")
