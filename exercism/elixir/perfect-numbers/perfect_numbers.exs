defmodule PerfectNumbers do
  @error_message "Classification is only possible for natural numbers."

  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number <= 0, do: {:error, @error_message}
  def classify(number) do
    number
    |> factors()
    |> Enum.sum()
    |> do_classify(number)
  end

  defp do_classify(1, 1), do: {:ok, :deficient}
  defp do_classify(sum, number) when sum == number, do: {:ok, :perfect}
  defp do_classify(sum, number) when sum > number, do: {:ok, :abundant}
  defp do_classify(sum, number) when sum < number, do: {:ok, :deficient}

  defp factors(1), do: [1]
  defp factors(number) do
    for test <- 1..div(number, 2), rem(number, test) == 0, do: test
  end
end
