defmodule DNA do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  4
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) do
    hamming(strand1, strand2, 0)
  end

  def hamming([], [], a), do: {:ok, a}
  def hamming([h|t1], [h|t2], a), do: hamming(t1, t2, a)
  def hamming([_|t1], [_|t2], a), do: hamming(t1, t2, a+1)
  def hamming(_, _, _), do: {:error, "Lists must be the same length."}
end
