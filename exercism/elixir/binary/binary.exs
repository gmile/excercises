defmodule Binary do
  import Bitwise, only: [<<<: 2]
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string), do: convert(String.to_char_list(string), 0)
  defp convert([], acc), do: acc
  defp convert([?0 | t], acc), do: convert(t, acc)
  defp convert([?1 | t], acc), do: convert(t, acc + (1 <<< length(t)))
  defp convert(_, _), do: 0
end
