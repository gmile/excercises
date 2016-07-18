defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a dict of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency([], _), do: %{}
  def frequency(texts, workers) do
    texts
    |> Enum.chunk(Enum.min([workers, length(texts)]))
    |> Enum.flat_map(fn(texts) ->
         texts
         |> Enum.map(fn(text) ->
              Task.async(__MODULE__, :work, [text])
            end)
         |> Task.yield_many()
       end)
    |> Enum.reduce(%{}, fn({_, { :ok, result }}, acc) ->
         Map.merge(acc, result, fn(_, v1, v2) -> v1 + v2 end)
       end)
  end

  def work(text) do
    Regex.scan(~r|\p{L}|u, String.downcase(text))
    |> List.flatten()
    |> Enum.reduce(%{}, fn(c, acc) ->
      Map.update(acc, c, 1, &(&1 + 1))
    end)
  end
end
