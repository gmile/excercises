defmodule Stack do  
  use GenServer

  def handle_call(:pop, _from, []) do
    {:reply, nil, []}
  end

  def handle_call(:pop, _from, state) do
    [head|new_state] = state

    {:reply, head, new_state}
  end

  def handle_cast({:push, value}, state) do
    {:noreply, [value|state]}
  end
end

{:ok, pid} = :gen_server.start_link(Stack, [], [])
:gen_server.cast(pid, { :push, 1 }) |> IO.puts
:gen_server.cast(pid, { :push, 2 }) |> IO.puts
:gen_server.cast(pid, { :push, 3 }) |> IO.puts
:gen_server.call(pid, :pop) |> IO.puts
:gen_server.call(pid, :pop) |> IO.puts
:gen_server.call(pid, :pop) |> IO.puts
