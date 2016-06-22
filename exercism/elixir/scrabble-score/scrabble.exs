defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer

  @naive_map %{
    'aeioulnrst' => 1,
    'dg'         => 2,
    'bcmp'       => 3,
    'fhvwy'      => 4,
    'k'          => 5,
    'jx'         => 8,
    'qz'         => 10
  }

  @map Enum.reduce(@naive_map, %{}, fn({letters, points}, acc) ->
    Enum.reduce(letters, acc, &put_in(&2, [&1], points))
  end)

  def score(""), do: 0
  def score(word), do: do_score(Regex.scan(~r/\p{L}+/, word))

  defp do_score([]), do: 0
  defp do_score([[chars]]) do
    chars
    |> String.downcase
    |> String.to_char_list
    |> Enum.map(&@map[&1])
    |> Enum.sum
  end
end
