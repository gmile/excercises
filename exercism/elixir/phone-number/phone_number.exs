defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """

  @error_sequence '0000000000'

  @spec number(String.t) :: String.t
  def number(raw) do
    raw
    |> prepare
    |> List.to_string
  end

  defp prepare(raw) do
    if raw =~ ~r/\p{L}/ do
      @error_sequence
    else
      Regex.scan(~r/\p{Nd}/, raw)
      |> List.flatten
      |> Enum.join
      |> String.to_char_list
      |> normalize
    end
  end

  defp normalize([?1|t] = l) when length(l) == 11, do: t
  defp normalize(l) when length(l) == 10, do: l
  defp normalize(_), do: @error_sequence

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw
    |> prepare
    |> Enum.take(3)
    |> List.to_string
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    number =
      raw
      |> prepare
      |> List.to_string

    << a::binary-size(3),
       b::binary-size(3),
       c::binary-size(4) >> = number

    "(#{a}) #{b}-#{c}"
  end
end
