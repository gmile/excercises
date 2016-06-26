defmodule Roman do
  @mapping [
    { 1000, "M" },
    { 900,  "CM" },
    { 500,  "D" },
    { 400,  "CD" },
    { 100,  "C" },
    { 90,   "XC" },
    { 50,   "L" },
    { 40,   "XL" },
    { 10,   "X" },
    { 9,    "IX" },
    { 5,    "V" },
    { 4,    "IV" },
    { 1,    "I" }
  ]

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer, String.t) :: String.t
  def numerals(number, acc \\ "")
  def numerals(0, acc), do: acc

  for { arabic, roman } <- @mapping do
    def numerals(number, acc) when number >= unquote(arabic) do
      numerals(number - unquote(arabic), acc <> unquote(roman))
    end
  end
end
