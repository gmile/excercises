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
        n = case char do
          ?a -> 10
          ?b -> 11
          ?c -> 12
          ?d -> 13
          ?e -> 14
          ?f -> 15
          ?0 -> 0
          ?1 -> 1
          ?2 -> 2
          ?3 -> 3
          ?4 -> 4
          ?5 -> 5
          ?6 -> 6
          ?7 -> 7
          ?8 -> 8
          ?9 -> 9
        end

        if index == 0 do
          acc + n
        else
          acc + n * (1 <<< index * 4)
        end
      end)
    else
      0
    end
  end
end
