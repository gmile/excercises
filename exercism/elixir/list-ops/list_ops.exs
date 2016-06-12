defmodule ListOps do
  # Please don't use any external modules (especially l) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.
  # 
  # Legend:
  #   l - list
  #   a - accumulator
  #   h - head
  #   t - tail

  @spec count(list) :: non_neg_integer
  def count(l), do: _count(l, 0)
  defp _count([], a), do: a
  defp _count([_|t], a), do: _count(t, a + 1)

  @spec reverse(list) :: list
  def reverse(l), do: _reverse(l, [])
  defp _reverse([], new_l), do: new_l
  defp _reverse([h | t], new_l), do: _reverse(t, [h | new_l])

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: _map(reverse(l), [], f)
  defp _map([], acc, _), do: acc
  defp _map([h | t], acc, f), do: _map(t, [f.(h) | acc] , f)

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: _filter(reverse(l), [], f)
  defp _filter([], acc, _), do: acc
  defp _filter([h | t], acc, f) do
    new_acc = if f.(h), do: [h | acc], else: acc

    _filter(t, new_acc, f)
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([h | t], acc, f), do: reduce(t, f.(h, acc), f)

  @spec append(list, list) :: list
  def append(a, []), do: a
  def append([], a), do: a
  def append(a, b), do: _append(reverse(a), b)
  defp _append([h | t], b), do: _append(t, [h | b])
  defp _append(a, []), do: a
  defp _append([], a), do: a

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([l | ll]), do: reverse(_concat(l, ll, []))
  def _concat([], [], acc), do: acc
  def _concat([h | t], ll, acc), do: _concat(t, ll, [h | acc])
  def _concat([], [h | t], acc), do: _concat(h, t, acc)
end
