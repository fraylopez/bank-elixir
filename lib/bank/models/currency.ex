defmodule Bank.Models.Currency do
  @supported_currencies [:EUR, :USD]

  @type supported_currencies ::
          unquote(
            @supported_currencies
            |> Enum.map(&inspect/1)
            |> Enum.join(" | ")
            |> Code.string_to_quoted!()
          )
end
