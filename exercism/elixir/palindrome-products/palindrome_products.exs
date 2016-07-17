defmodule Palindromes do
  require Integer

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    (for a <- min_factor..max_factor-1,
        b <- a..max_factor,
        palindrome?(a * b),
        do: [a, b])
    |> Enum.group_by(fn [a, b] -> a * b end)
  end

  def palindrome?(number) do
    n = Integer.digits(number)
    n == Enum.reverse(n)
  end
end
