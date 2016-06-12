defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l), do: _count(l, 0)
  defp _count([], acc), do: acc
  defp _count([_|tail], acc), do: _count(tail, acc + 1)

  @spec reverse(list) :: list
  def reverse(l), do: _reverse(l, [])
  defp _reverse([], new_list), do: new_list
  defp _reverse([head | tail], new_list), do: _reverse(tail, [head | new_list])

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: _map(reverse(l), [], f)
  defp _map([], acc, _), do: acc
  defp _map([head | tail], acc, f), do: _map(tail, [f.(head) | acc] , f)

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: _filter(reverse(l), [], f)
  defp _filter([], acc, _), do: acc
  defp _filter([head | tail], acc, f) do
    new_acc = if f.(head), do: [head | acc], else: acc

    _filter(tail, new_acc, f)
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([head | tail], acc, f), do: reduce(tail, f.(head, acc), f)

  @spec append(list, list) :: list
  def append(a, []), do: a
  def append([], a), do: a
  def append(a, b), do: _append(reverse(a), b)
  defp _append([head | tail], b), do: _append(tail, [head | b])
  defp _append(a, []), do: a
  defp _append([], a), do: a

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([l | ll]), do: reverse(_concat(l, ll, []))
  def _concat([], [], acc), do: acc
  def _concat([head | tail], ll, acc), do: _concat(tail, ll, [head | acc])
  def _concat([], [head | tail], acc), do: _concat(head, tail, acc)
end
