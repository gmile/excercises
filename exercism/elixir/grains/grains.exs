defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) do
    [acc, _] = do_square(number, 1, 0)
    acc
  end

  defp do_square(1, acc, total), do: [acc, 1 + total]
  defp do_square(n, acc, total), do: do_square(n - 1, acc * 2, total + acc * 2)

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    [_, total] = do_square(64, 1, 0)
    total
  end
end
