defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a dict of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    current = self()

    IO.puts("#{inspect current}: spawning workers...")
    pids =
      Enum.map(1..workers, fn(_worker) ->
        spawn(__MODULE__, :do_work_for, [current])
      end)

    IO.puts("#{inspect current}: sending jobs...")
    pids
    |> Stream.cycle()
    |> Enum.zip(texts)
    |> Enum.each(fn { worker_pid, text } ->
         send(worker_pid, { :work_on, text })
       end)

    IO.puts("#{inspect current}: waiting for results from workers...")
    wait_for_all(length(texts), %{})
  end

  defp wait_for_all(0, final_result), do: final_result
  defp wait_for_all(jobs_left, final_result) do
    result =
      receive do
        { :job_is_done, result } -> result
      end

    wait_for_all(jobs_left - 1, Map.merge(final_result, result, fn(_, v1, v2) -> v1 + v2 end))
  end

  def do_work_for(parent_pid) do
    IO.puts("#{inspect self()}: waiting for work to do...")
    receive do
      { :work_on, text } ->
        result =
          text
          |> String.downcase()
          |> String.graphemes()
          |> Enum.reduce(%{}, fn(c, acc) ->
            Map.update(acc, c, 1, &(&1 + 1))
          end)

        IO.puts("#{inspect self()}: done working! Sending result to #{inspect parent_pid}...")
        send(parent_pid, { :job_is_done, result })
    end

    do_work_for(parent_pid)
  end
end