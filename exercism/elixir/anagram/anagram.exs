defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    base_downcase = String.downcase(base)
    base_codepoints = codepoints(base_downcase)

    Enum.filter(candidates, fn(candidate) ->
      cand_downcase = String.downcase(candidate)

      cand_downcase != base_downcase &&
      codepoints(cand_downcase) == base_codepoints
    end)
  end

  def codepoints(string) do
    string
    |> String.codepoints
    |> Enum.group_by(&(&1))
  end
end
