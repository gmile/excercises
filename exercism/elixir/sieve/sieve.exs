defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    Enum.reduce(2..limit, [], fn(e, acc) ->
      if Enum.all?(acc, fn(x) -> rem(e, x) > 0 end) do
        [e | acc]
      else
        acc
      end
    end)
    |> Enum.reverse
  end
end
