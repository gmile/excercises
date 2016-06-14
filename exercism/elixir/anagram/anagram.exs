defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    base_ = String.downcase(base)
    fingerprint = fingerprint(base_)

    Enum.filter(candidates, fn(candidate) ->
      cand_ = String.downcase(candidate)
      cand_ != base_ && fingerprint(cand_) == fingerprint
    end)
  end

  def fingerprint(string) do
    string
    |> String.codepoints
    |> Enum.sort
  end
end
