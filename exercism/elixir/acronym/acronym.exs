defmodule Acronym do
  @doc """
  Generate an acronym from a string. 
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    a = string
    |> String.split(" ")
    |> Enum.map(&String.capitalize(&1))

    IO.inspect(a)

    a = a
    |> Enum.map(fn(s) -> Regex.scan(~r/\p{Lu}/, s) end)

    IO.inspect(a)

    a
    |> Enum.reduce("", fn([[e]], acc) -> acc <> e end)
  end
end
