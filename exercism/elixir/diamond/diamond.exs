defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(?A), do: "A\n"
  def build_shape(letter) do
    total = letter - ?A
    empty_line = List.duplicate(?\s, 2 * total - 1)

    top = Enum.map(?A..letter-1, &build_line(empty_line, total, &1))
    result = (top ++ [build_line(empty_line, total, letter)] ++ Enum.reverse(top))
    Enum.join(result, "\n") <> "\n"
  end

  def build_line(empty_line, total, ?A) do
    empty_line
    |> List.insert_at(total, 'A ')
  end

  def build_line(empty_line, total, letter) do
    empty_line
    |> List.insert_at(total - (letter - ?A), letter)
    |> List.insert_at(total + (letter - ?A), letter)
  end
end
