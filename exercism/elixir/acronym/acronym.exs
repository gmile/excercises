defmodule Acronym do
  @doc """
  Generate an acronym from a string. 
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split(" ")
    |> capitalize_words
    |> select_capital_letters
    |> Enum.join
  end

  def capitalize_words(words) do
    Enum.map(words, fn word ->
      [ first_letter | rest_of_string ] = String.codepoints(word)
      List.to_string([ String.upcase(first_letter) | rest_of_string ])
    end)
  end

  def select_capital_letters(words) do
    Enum.map(words, fn word ->
      String.to_charlist(word)
    end) fn(word) -> Regex.scan(~r/\p{Lu}/, word) end)
    |> List.flatten
  end
end
