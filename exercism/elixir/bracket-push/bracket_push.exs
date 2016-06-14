defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    Regex.scan(~r/\p{Ps}|\p{Pe}/, str)
    |> List.flatten
    |> check
  end

  defp check(_, stack \\ [])
  defp check([], []), do: true
  defp check([], _), do: false
  defp check([h1|t1], []), do: check(t1, [h1])
  defp check([h1|t1], [h2|t2] = stack) do
    cond do
      h1 =~ ~r/\p{Ps}/ ->
        check(t1, [h1 | stack])
      h1 =~ ~r/\p{Pe}/ && friends?(h2, h1) ->
        check(t1, t2)
      true ->
        false
    end
  end

  defp friends?(s, e) do
    s == "(" && e == ")" ||
    s == "[" && e == "]" ||
    s == "{" && e == "}"
  end
end
