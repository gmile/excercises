defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    Enum.into(2..limit, [])
    |> do_sieve([])
    |> Enum.reverse
  end

  defp do_sieve([n], acc), do: [n | acc]
  defp do_sieve([n | list], acc) do
    list
    |> Enum.filter(&(rem(&1, n) != 0))
    |> do_sieve([n | acc])
  end
end
