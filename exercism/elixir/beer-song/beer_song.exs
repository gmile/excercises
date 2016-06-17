defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t
  def verse(1), do: _verse("no more bottles", "99 bottles")
  def verse(2), do: _verse("1 bottle", "no more bottles")
  def verse(3), do: _verse("2 bottles", "1 bottle")
  def verse(n), do: _verse("#{n - 1} bottles", "#{n - 2} bottles")

  defp _verse(a, b) do
    """
    #{line1(a)}
    #{line2(b)}
    """
  end

  defp line1(phrase), do: "#{String.capitalize(phrase)} of beer on the wall, #{phrase} of beer."

  defp line2("99 bottles"), do: "Go to the store and buy some more, 99 bottles of beer on the wall."
  defp line2("no more bottles"), do: "Take it down and pass it around, no more bottles of beer on the wall."
  defp line2(n_bottles), do: "Take one down and pass it around, #{n_bottles} of beer on the wall."

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t) :: String.t
  def lyrics, do: lyrics(100..1)

  def lyrics(range) do
    range
    |> Enum.map(fn(e) -> verse(e) end)
    |> Enum.join("\n")
  end
end
