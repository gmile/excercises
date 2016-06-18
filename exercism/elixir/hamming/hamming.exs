defmodule DNA do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  4
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) do
    hd(strand1, strand2, 0)
  end

  def hd([], [], a), do: a
  def hd([h|t1], [h|t2], a), do: hd(t1, t2, a)
  def hd([_|t1], [_|t2], a), do: hd(t1, t2, a+1)
  def hd(_, _, _), do: nil
end
