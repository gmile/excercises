defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    2
    |> do_sieve(Enum.into(2..limit, []), [])
    |> Enum.reverse
  end

  defp do_sieve(n, [], acc), do: [n | acc]
  defp do_sieve(n, list, acc) do
    [new_n | survivors] = Enum.filter(list, fn(e) -> rem(e, n) != 0 end)
    do_sieve(new_n, survivors, [n | acc])
  end
end
