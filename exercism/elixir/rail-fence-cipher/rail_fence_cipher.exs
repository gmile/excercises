defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t, pos_integer) :: String.t
  def encode(str, 1), do: str
  def encode(str, rails) when rails > length(str), do: str
  def encode(str, rails) do
    str
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.group_by(&rem(&1, rails))
    |> Map.values()
    |> List.flatten()
    |> Enum.map_join(fn { c, i } -> c end)
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
