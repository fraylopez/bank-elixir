import Config

config :bank, :account_repository, Bank.Infrastructure.InMemoryAccountRepository

import_config("#{Mix.env()}.exs")
