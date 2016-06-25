defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t) :: String.t
  def encode(""), do: ""
  def encode(str) do
    str =
      str
      |> String.downcase
      |> String.replace(~r|[^\w]|, "")
      |> String.to_char_list

    cols = cols_rows(length(str))

    str
    |> Enum.chunk(cols, cols, Stream.cycle(' '))
    |> List.zip
    |> Enum.map_join(" ", fn(e) ->
      e
      |> Tuple.to_list
      |> List.to_string
      |> String.trim_trailing
    end)
  end

  def cols_rows(length) do
    (for r <- 1..length,
        c <- 1..length,
        c >= r,
        c <= r + 1,
        length <= c * r,
     do: c) |> hd
  end
end
