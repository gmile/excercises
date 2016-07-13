defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    (for n <- 1..limit-1,
         f <- factors,
         rem(n, f) == 0, do: n) |> Enum.uniq |> Enum.reduce(0, &(&1 + &2))
  end
end
