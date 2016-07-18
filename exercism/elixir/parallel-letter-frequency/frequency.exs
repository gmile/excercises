defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a dict of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    texts
    |> Enum.each(fn(text) ->
      spawn_link(__MODULE__, :do_frequency, [self(), text])
    end)

    result_from(workers)
  end

  def do_frequency(parent_pid, text) do
    result =
      text
      |> String.graphemes()
      |> Enum.reduce(%{}, fn(c, acc) ->
        Map.update(acc, c, 1, &(&1 + 1))
      end)

    send(parent_pid, { :ok, result })
  end

  def result_from(workers, final_result // %{})
  def result_from(0, final_result), do: final_result
  def result_from(workers, final_result) do
    receive do
      { :ok, result } ->
        result_from(workers - 1, Map.merge(final_result, result, fn(_, v1, v2) -> v1 + v2 end))
    end
  end
end
