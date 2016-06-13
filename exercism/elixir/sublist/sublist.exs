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

  def _compare(_, _, false), do: false
  def _compare([], [], true), do: true
  def _compare([h1|t1], [h2|t2], _) do
    _compare(t1, t2, h1 == h2)
  end

  def _compare([], super, _, _) when length(super) >= 0, do: true
  def _compare(sub, super, _, _) when length(sub) > length(super), do: false
  def _compare([h1|t1], [h2|t2], backup1, [_|bt] = backup2) do
    if h1 === h2 do
      _compare(t1, t2, backup1, backup2)
    else
      _compare(backup1, bt, backup1, bt)
    end
  end
end
