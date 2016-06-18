defmodule Grains do
  import Bitwise, only: ["<<<": 2]

  def square(number), do: 1 <<< (number - 1)
  def total, do: (1 <<< 64) - 1
end
