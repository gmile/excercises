defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    number
    |> convert
    |> Enum.reverse
    |> Enum.join
  end

  def convert(number, d \\ 1000, acc \\ [])
  def convert(number, 0, acc), do: [part(number, 1) | acc]
  def convert(number, d, acc), do: convert(rem(number, d), div(d, 10), [part(number, d) | acc])

  def part(number, d) do
    { a, b, c } = digits(d)

    case div(number, d) do
      0 -> ""
      1 -> a
      2 -> a <> a
      3 -> a <> a <> a
      4 -> a <> b
      5 -> b
      6 -> b <> a
      7 -> b <> a <> a
      8 -> b <> a <> a <> a
      9 -> a <> c
    end
  end

  def digits(1), do: { "I", "V", "X" }
  def digits(10), do: { "X", "L", "C" }
  def digits(100), do: { "C", "D", "M" }
  def digits(1000), do: { "M", nil, nil }
end
