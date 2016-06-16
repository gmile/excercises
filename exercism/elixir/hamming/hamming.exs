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
  def hd(s1, s2, _) when length(s1) != length(s2), do: nil
  def hd([h1|t1], [h2|t2], a) when h1 != h2, do: hd(t1, t2, a+1)
  def hd([h1|t1], [h2|t2], a) when h1 == h2, do: hd(t1, t2, a)
end
