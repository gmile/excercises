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
    line_counts =
      0
      |> List.duplicate(rails)
      |> Enum.with_index()
      |> get_line_counts(String.length(str), [])
      |> Enum.sort_by(&elem(&1, 1))
      |> Enum.unzip()
      |> elem(0)

    get_lines(str, line_counts)
    # |> Enum.sort_by(&elem(&1, 1))
    # |> Enum.map(&elem(&1, 0) |> Enum.reverse)
    # |> List.flatten()
    # |> to_string()
  end

  def get_lines("", _, out), do: out
  def get_lines(str, [h|t], out) do
    String.split(str, h)
  end

  def get_line_counts(a, 0, b), do: a ++ b
  def get_line_counts([{ count, index }], rails, b) do
    get_line_counts(b, rails - 1, [{ count + 1, index }])
  end

  def get_line_counts([{ count, index } | a], rails, b) do
    get_line_counts(a, rails - 1, [{ count + 1, index } | b])
  end
end
