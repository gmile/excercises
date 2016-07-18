defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a dict of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    current = self()

    pids =
      Enum.map(1..workers, fn(_worker) ->
        spawn_link(__MODULE__, :do_work_for, [current])
      end)

    texts
    |> Enum.chunk(workers)
    |> Enum.each(fn(texts) ->
         Enum.zip(pids, texts)
         |> Enum.each(&send(&1, { :work_on, &2 }))
       end)

    wait_for_all(length(texts), %{})
  end

  def wait_for_all(0, final_result), do: final_result
  def wait_for_all(number_of_texts, final_result) do
    result =
      receive do
        { :job_is_done, result } -> result
      end

    wait_for_all(number_of_texts - 1, Map.merge(final_result, result, fn(_, v1, v2) -> v1 + v2 end))
  end

  def do_work_for(parent_pid) do
    receive do
      { :work_on, text } ->
        result =
          text
          |> String.downcase()
          |> String.graphemes()
          |> Enum.reduce(%{}, fn(c, acc) ->
            Map.update(acc, c, 1, &(&1 + 1))
          end)

        send(parent_pid, { :job_is_done, result })
    end

    do_work_for(parent_pid)
  end
end
