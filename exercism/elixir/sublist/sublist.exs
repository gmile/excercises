defmodule Sublist do
  require IEx
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(l1, l2) do
    cond do
      length(l1) > length(l2) && _compare(l2, l1, l2, l1) ->
        :superlist
      length(l1) < length(l2) && _compare(l1, l2, l1, l2) ->
        :sublist
      length(l1) == length(l2) && _compare(l1, l2, true) ->
        :equal
      true ->
        :unequal
    end
  end

  # comparing lists of equal size
  def _compare(_, _, false), do: false
  def _compare([], [], true), do: true
  def _compare([h1|t1], [h2|t2], _), do: _compare(t1, t2, h1 == h2)

  # comparing small list (l1) against big list (l2)
  def _compare([], l2, _, _) when length(l2) >= 0, do: true
  def _compare(l1, l2, _, _) when length(l1) > length(l2), do: false
  def _compare([h1|t1], [h2|t2], l1bckp, l2bckp) when h1 === h2, do: _compare(t1, t2, l1bckp, l2bckp)
  def _compare([h1|_], [h2|_], l1bckp, [_|t]) when h1 !== h2, do: _compare(l1bckp, t, l1bckp, t)
end
