defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t) :: integer
  def answer(<<"What is ", expression::binary>>) do
    { number, rest } = Integer.parse(expression)
    do_answer(rest, number)
  end

  def answer(_), do: raise ArgumentError

  def do_answer(<< " minus ", expression::binary >>, acc) do
    { number, rest } = Integer.parse(expression)
    do_answer(rest, acc - number)
  end

  def do_answer(<< " plus ", expression::binary >>, acc) do
    { number, rest } = Integer.parse(expression)
    do_answer(rest, acc + number)
  end

  def do_answer(<< " divided by ", expression::binary >>, acc) do
    { number, rest } = Integer.parse(expression)
    do_answer(rest, acc / number)
  end

  def do_answer(<< " multiplied by ", expression::binary >>, acc) do
    { number, rest } = Integer.parse(expression)
    do_answer(rest, acc * number)
  end

  def do_answer(<< "?" >>, acc), do: acc

  def do_answer(_, _), do: raise ArgumentError
end
