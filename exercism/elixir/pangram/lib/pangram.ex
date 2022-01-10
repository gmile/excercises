defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    all = ?a..?z

    sentence
    |> String.split("")
    |> Enum.map(&String.downcase(&1))
    |> Enum.filter(fn l -> Enum.at(String.to_charlist(l), 0) in all end)
    |> Enum.sort
    |> Enum.uniq
    |> Enum.join
    |> String.to_charlist
    == Enum.to_list(?a..?z)
  end
end
