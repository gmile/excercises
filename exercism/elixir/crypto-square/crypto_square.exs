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

    cols = :math.sqrt(length(str)) |> Float.ceil |> trunc

    str
    |> Enum.chunk(cols, cols, Stream.repeatedly(fn -> '' end))
    |> List.zip
    |> Enum.map_join(" ", fn(e) ->
      e
      |> Tuple.to_list
      |> List.to_string
    end)
  end
end
