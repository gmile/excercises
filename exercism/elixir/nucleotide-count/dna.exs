defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    if nucleotide in @nucleotides && Enum.all?(strand, fn(e) -> e in @nucleotides end) do
      Enum.count(strand, fn(e) -> e == nucleotide end)
    else
      raise ArgumentError
    end
  end

  @spec histogram([char]) :: map
  def histogram(strand) do
    Enum.reduce('ATCG', %{}, fn(c, acc) ->
      Map.put(acc, c, count(strand, c))
    end)
  end
end
