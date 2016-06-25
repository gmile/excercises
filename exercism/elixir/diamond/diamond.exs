defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(?A), do: "A\n"
  def build_shape(letter) do
    total = letter - ?A
    empty_row = List.duplicate(?\s, 2 * total - 1)

    top = Enum.map(?A..letter-1, &build_line(empty_row, total, &1))
    result = (top ++ [build_line(empty_row, total, letter)] ++ Enum.reverse(top))
    Enum.join(result, "\n") <> "\n"
  end

  def build_line(empty_row, total, ?A) do
    empty_row
    |> List.insert_at(total, 'A ')
  end

  def build_line(empty_row, total, letter) do
    empty_row
    |> List.insert_at(total - (letter - ?A), letter)
    |> List.insert_at(total + (letter - ?A), letter)
  end
end
# 
# total = letter - ?A + 1
# empty_row = List.duplicate(?_, 2 * total - 1)
# Diamond.build_line(empty_row, total,