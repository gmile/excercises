defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    fun = fn
      {1, 0}, acc -> ["wink" | acc]
      {1, 1}, acc -> ["double blink" | acc]
      {1, 2}, acc -> ["close your eyes" | acc]
      {1, 3}, acc -> ["jump" | acc]
      {1, 4}, acc -> Enum.reverse(acc)
      {_, _}, acc -> acc
    end

    code
    |> Integer.digits(2)
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce([], fun)
    |> Enum.reverse()
  end
end
