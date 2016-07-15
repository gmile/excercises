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
    |> Enum.reduce(%{}, fn(palindrom, acc) ->
      factors =
        (for a <- min_factor..max_factor,
             rem(palindrom, a) == 0,
             div(palindrom, a) <= max_factor,
             do: [div(palindrom, a), a])
      |> Enum.map(&Enum.sort/1)
      |> Enum.uniq

      put_in(acc[palindrom], factors)
    end)
    |> Enum.filter(fn {a,l} -> length(l) > 0 end)
    |> Enum.into(%{})

    IO.inspect(palindroms)

    palindroms
  end

  def palindromes(1), do: for a <- 0..9, do: [a]
  def palindromes(2), do: for a <- 0..9, do: [a, a]
  def palindromes(n) do
    for a <- 1..9,
        b <- palindromes(n - 2),
        do: [a | ([a | b] |> Enum.reverse)]
  end
end
