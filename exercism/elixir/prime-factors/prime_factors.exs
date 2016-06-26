defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest. 
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    number |> f |> Enum.reverse
  end

  def f(a, test \\ 2, acc \\ [])
  def f(1, _, acc), do: acc
  def f(number, test, acc) when rem(number, test) == 0, do: f(div(number, test), test, [test | acc])
  def f(number, test, acc), do: f(number, test + 1, acc)
end
