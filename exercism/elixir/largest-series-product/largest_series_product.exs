defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(_, 0), do: 1
  def largest_product(number_string, size) do
    chars = String.to_charlist(number_string)

    if size < 0 || length(chars) < size, do: raise ArgumentError

    chars
    |> Enum.chunk(size, 1)
    |> Enum.map(&Enum.reduce(&1, 1, fn(e, acc) -> acc * (e - ?0) end))
    |> Enum.max
  end
end
