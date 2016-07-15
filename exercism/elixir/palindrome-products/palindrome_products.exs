defmodule Palindromes do

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    min_size =
      min_factor
      |> Integer.to_string()
      |> String.length()

    max_size =
      max_factor
      |> Integer.to_string()
      |> String.length()

    palindroms =
      palindromes(min_size * max_size)
      |> Enum.filter(&(&1 != 0))
      |> Enum.map(fn p ->
        p
        |> Enum.join()
        |> Integer.parse()
        |> elem(0)
      end)

    IO.inspect("-------- #{inspect palindroms} --------")

    (for a <- min_factor..max_factor,
         palindrom <- palindroms,
         rem(palindrom, a) == 0,
         div(palindrom, a) <= max_factor,
         palindrom > 0,
         do: [a, div(palindrom, a)])
  end

  def palindromes(1), do: for a <- 0..9, do: [a]
  def palindromes(2), do: for a <- 0..9, do: [a, a]
  def palindromes(n) do
    for a <- 1..9,
        b <- palindromes(n - 2),
        do: [a | ([a | b] |> Enum.reverse)]
  end
end
