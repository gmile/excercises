defmodule Palindromes do
  require Integer

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    p =
      for a <- min_factor..max_factor-1,
          b <- a..max_factor,
          palindrome?(a * b),
          do: [a, b]

    p |> Enum.group_by(fn [a, b] -> a * b end)
  end

  def palindrome?(number) do
    s = to_string(number) |> String.to_char_list()
    l = length(s)
    {a, b} = Enum.split(s, div(l, 2))

    if Integer.is_even(l) do
      a == Enum.reverse(b)
    else
      [_|x] = b
      a == Enum.reverse(x)
    end
  end
end
