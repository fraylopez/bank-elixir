defmodule Bank.Accounts.Models.Currency do
  @supported_currencies [:EUR, :USD]

  @type supported_currencies ::
          unquote(
            @supported_currencies
            |> Enum.join(" | ")
            |> Code.string_to_quoted!()
          )

  def supported?(currency) do
    currency in @supported_currencies
  end
end
