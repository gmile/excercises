defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    do_convert(number, [])
  end

  Enum.each(%{ 3 => "Pling", 5 => "Plang", 7 => "Plong" }, fn {n, w} ->
    defp do_convert(number, acc) when rem(number, unquote(n)) == 0 do
      do_convert(div(number, unquote(n)), [unquote(w) | acc])
    end
  end)

  defp do_convert(number, []), do: Integer.to_string(number)
  defp do_convert(_, acc), do: acc |> Enum.uniq |> Enum.reverse |> Enum.join
end
