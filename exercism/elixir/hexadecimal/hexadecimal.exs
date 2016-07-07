defmodule Hexadecimal do
  import Bitwise, only: [<<<: 2]
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    if hex =~ ~r/^[A-Fa-f0-9]+$/ do
      hex
      |> String.downcase
      |> String.to_char_list
      |> Enum.reverse
      |> Enum.with_index
      |> Enum.reduce(0, fn({ char, index }, acc) ->
        n =
        cond do
          char in ?a..?f -> char - 87
          char in ?0..?9 -> char - 48
        end

        acc + if index == 0, do: n, else: n * (1 <<< index * 4)
      end)
    else
      0
    end
  end
end
