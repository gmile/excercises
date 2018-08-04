defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    walk(list, fun, [], true) |> Enum.reverse()
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    walk(list, fun, [], false) |> Enum.reverse()
  end

  defp walk([], _fun, acc, _criterion), do: acc
  defp walk([head | tail], fun, acc, criterion) do
    if fun.(head) == criterion do
      walk(tail, fun, [head | acc], criterion)
    else
      walk(tail, fun, acc, criterion)
    end
  end
end
