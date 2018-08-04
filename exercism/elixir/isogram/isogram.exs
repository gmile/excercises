defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.downcase()
    |> String.to_char_list()
    |> Enum.group_by(& &1, & &1)
    |> Enum.all?(fn {char, count} -> (char in [32, 45]) or length(count) == 1 end)
  end
end
