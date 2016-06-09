defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    Enum.reduce(Regex.scan(~r/[\p{L}0-9-]+/u, sentence), %{}, fn [word], acc->
      { _, acc } = Map.get_and_update(acc, String.downcase(word), fn(current_value) ->
        case current_value do
          nil -> { nil, 1 }
          _ -> { current_value, current_value + 1 }
        end
      end)
      acc
    end)
  end
end
