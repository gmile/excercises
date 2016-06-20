defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number 
    |> String.reverse
    |> String.to_char_list
    |> chksum
  end

  defp chksum(numbers, flag \\ 1, checksum \\ 0)
  defp chksum([], _, total), do: total
  defp chksum([h|t], 1, total), do: chksum(t, 2, total + add(List.to_integer([h])))
  defp chksum([h|t], 2, total), do: chksum(t, 1, total + add(List.to_integer([h]) * 2))
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
      checksum = checksum(number <> "0")

      if rem(checksum, 10) == 0 do
        number <> "0"
      else
        number <> Integer.to_string(10 - rem(checksum, 10))
      end
    end
  end
end
