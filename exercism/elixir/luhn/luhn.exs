defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number 
    |> String.reverse
    |> String.to_char_list
    |> do_checksum
  end

  defp do_checksum(numbers, flag \\ 1, checksum \\ 0)
  defp do_checksum([], _, total), do: total
  defp do_checksum([h|t], 1, total), do: do_checksum(t, 2, total + add(List.to_integer([h])))
  defp do_checksum([h|t], 2, total), do: do_checksum(t, 1, total + add(List.to_integer([h]) * 2))
  defp add(x) when x <= 9, do: x
  defp add(x) when x  > 9, do: x - 9

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number), do: rem(checksum(number), 10) == 0

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) do
    if valid?(number) do
      number
    else
      checksum = checksum(number <> "0") |> rem(10)
      number <> if checksum == 0, do: "0", else: to_string(10 - checksum)
    end
  end
end
