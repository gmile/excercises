defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t, pos_integer) :: String.t
  def encode(str, 1), do: str
  def encode(str, rails) when rails > length(str), do: str
  def encode(str, rails) do
    lines =
      []
      |> List.duplicate(rails)
      |> Enum.with_index()

    str
    |> spread_on(lines, [])
    |> Enum.sort_by(&elem(&1, 1))
    |> Enum.map(&elem(&1, 0) |> Enum.reverse)
    |> List.flatten()
    |> to_string()
  end

  def spread_on("", a, b), do: a ++ b
  def spread_on(<< char, rest::binary >>, [{ line, index }], lines) do
    spread_on(rest, lines, [{ [char|line], index }])
  end

  def spread_on(<< char, rest::binary >>, [{ line, index } | other_lines], lines) do
    spread_on(rest, other_lines, [{ [char|line], index } | lines])
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t, pos_integer) :: String.t
  def decode(str, 1), do: str
  def decode(str, rails) when rails > length(str), do: str
  def decode(str, rails) do

  end
end
