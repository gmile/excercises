defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    x = plaintext
    |> do_encode()
    |> String.to_char_list

    x
    |> Enum.chunk(5, 5, [])
    |> Enum.join(" ")
  end

  def do_encode(binary, acc \\ "")
  def do_encode(<<>>, acc), do: acc
  def do_encode(<< char, rest::binary >>, acc) when char in ?A..?Z do
    do_encode(rest, acc <> << ?A - char + ?z >>)
  end

  def do_encode(<< char, rest::binary >>, acc) when char in ?a..?z do
    do_encode(rest, acc <> << ?a - char + ?z >>)
  end

  def do_encode(<< char, rest::binary >>, acc) when char in ?0..?9 do
    do_encode(rest, acc <> << char >>)
  end

  def do_encode(<< char, rest::binary >>, acc), do: do_encode(rest, acc)
end
