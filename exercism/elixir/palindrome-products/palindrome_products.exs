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

    IO.puts("----------- palindroms: #{inspect palindroms}")

    palindroms
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

    palindroms
  end

  def ppp(n) do
    n
    |> palindromes()
    |> Enum.map(fn l ->
      l
      |> Enum.map(fn x ->
           x
           |> Enum.join
           |> Integer.parse
           |> elem(0)
         end)
      end)
    |> List.flatten
  end

  def palindromes(1) do
    [(for a <- 1..9, do: [a])]
  end

  def palindromes(2) do
    [(for a <- 1..9, do: [a, a]) | palindromes(1)]
  end

  def palindromes(n) do
    z = palindromes(n - 1)
    [_, two |_ ] = z

    new_pals =
      for a <- 1..9,
          b <- [List.duplicate(0, n - 2) | two],
          do: [a | ([a | b] |> Enum.reverse)]

    [new_pals | z]
  end
end
