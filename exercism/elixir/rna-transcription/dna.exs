defmodule DNA do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> DNA.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.reverse(to_rna(dna, []))
  end

  def to_rna([], acc), do: acc
  def to_rna([char|rest_of_dna] = dna, acc) do
    new_char = case char do
      ?G -> ?C
      ?C -> ?G
      ?T -> ?A
      ?A -> ?U
    end

    to_rna(rest_of_dna, [new_char | acc])
  end
end
