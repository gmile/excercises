defmodule Grains do
  import Bitwise, only: ["<<<": 2]
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number), do: 1 <<< (number - 1)

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total, do: (1 <<< 64) - 1
end
