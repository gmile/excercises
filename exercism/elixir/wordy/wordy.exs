defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t) :: integer
  def answer(<<"What is ", expression::binary>>) do
    [ n | rest ] =
      expression
      |> String.replace("?", "")
      |> String.replace("minus", "-")
      |> String.replace("plus", "+")
      |> String.replace("multiplied by", "*")
      |> String.replace("divided by", "/")
      |> String.split(" ")
      |> Enum.map(fn(e) ->
        case e |> Integer.parse do
          { n, "" } -> n
          :error -> e
        end
      end)

    do_answer(rest, n)
  end

  def do_answer(list, acc \\ 0)
  def do_answer([], acc), do: acc
  def do_answer([op], acc), do: raise ArgumentError
  def do_answer([op, n | rest], acc) do
    acc = case op do
      "+" -> acc + n
      "-" -> acc - n
      "*" -> acc * n
      "/" -> acc / n
    end

    do_answer(rest, acc)
  end

  def answer(_), do: raise ArgumentError
end
