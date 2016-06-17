defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    Enum.reduce(Regex.scan(~r/[\p{L}0-9-]+/u, sentence), %{}, fn [word], acc ->
      Map.update(acc, String.downcase(word), 1, &(1+&1))
    end)
  end
end
