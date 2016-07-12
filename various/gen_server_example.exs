defmodule Stack do  
  use GenServer

  def start_link(state) do
    { :ok, pid } = :gen_server.start_link(__MODULE__, state, [])

    pid
  end

  def push(pid, value) do
    :gen_server.cast(pid, { :push, value })
  end

  def pop(pid) do
    :gen_server.call(pid, :pop)
  end

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

pid = Stack.start_link([1])
pid |> Stack.push(2)
pid |> Stack.push(3)
pid |> Stack.pop |> IO.puts
pid |> Stack.pop |> IO.puts
pid |> Stack.pop |> IO.puts
