defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a dict of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    current = self()

    1..workers
    |> Enum.map(fn(_worker) -> spawn(__MODULE__, :do_work_for, [current]) end)
    |> Stream.cycle()
    |> Enum.zip(texts)
    |> Enum.each(fn { worker_pid, text } ->
         send(worker_pid, { :work_on, text })
       end)

    wait_for_all(length(texts), %{})
  end

  defp wait_for_all(0, final_result), do: final_result
  defp wait_for_all(jobs_left, final_result) do
    result =
      receive do
        { :job_is_done, result } ->
          Map.merge(final_result, result, fn(_, v1, v2) -> v1 + v2 end)
      end

    wait_for_all(jobs_left - 1, result)
  end

  def do_work_for(parent_pid) do
    receive do
      { :work_on, text } ->
        result =
          Regex.scan(~r|\p{L}|u, String.downcase(text))
          |> List.flatten()
          |> Enum.reduce(%{}, fn(c, acc) ->
            Map.update(acc, c, 1, &(&1 + 1))
          end)

        send(parent_pid, { :job_is_done, result })
    end

    do_work_for(parent_pid)
  end
end
