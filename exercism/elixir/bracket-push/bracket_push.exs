defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    str
    |> String.to_char_list
    |> check
  end

  defp check(_, stack \\ [])
  defp check([], []), do: true
  defp check([], _), do: false
  defp check([h1|t1], stack) when h1 in '[{(' do
    check(t1, [h1 | stack])
  end
  defp check([h1|t1], [h2|t2]) when h1 in ']})' do
    if friends?(h2, h1) do
      check(t1, t2)
    else
      false
    end
  end
  defp check([_|t1], stack), do: check(t1, stack)

  defp friends?(?(, ?)), do: true
  defp friends?(?[, ?]), do: true
  defp friends?(?{, ?}), do: true
  defp friends?(_, _), do: false
end
