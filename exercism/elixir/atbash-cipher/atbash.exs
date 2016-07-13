defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    plaintext
    |> do_encode()
    |> String.to_char_list
    |> Enum.chunk(5, 5, [])
    |> Enum.join(" ")
  end

  def do_encode(binary, acc \\ "")
  def do_encode(<<>>, acc), do: acc
  def do_encode(<< char, rest::binary >>, acc) do
    new_char =
      cond do
        char in ?A..?Z -> << ?A - char + ?z >>
        char in ?a..?z -> << ?a - char + ?z >>
        char in ?0..?9 -> << char >>
        true           -> << >>
      end

    do_encode(rest, acc <> new_char)
  end
end
