defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    base_codepoints = codepoints(base)

    Enum.filter(candidates, fn(candidate) ->
      String.downcase(candidate) != String.downcase(base) &&
      codepoints(candidate) == base_codepoints
    end)
  end

  def codepoints(string) do
    string
    |> String.downcase
    |> String.codepoints
    |> Enum.group_by(&(&1))
  end
end
