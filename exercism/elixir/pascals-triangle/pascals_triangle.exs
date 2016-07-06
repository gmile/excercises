defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    do_rows(1, num, [[1]])
  end

  def do_rows(i, num, [h | _] = acc) do
    cond do
      i < num -> do_rows(i + 1, num, [row(h, []) | acc])
      i == num -> Enum.reverse(acc)
    end
  end

  def row([1], acc), do: [1 | Enum.reverse([1 | acc])]
  def row([a, b | tail], acc), do: row([b | tail], [a + b | acc])
end
