defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns :error if it is not possible to compute the right amount of coins.
    Otherwise returns the tuple {:ok, map_of_coins}

    ## Examples

      iex> Change.generate(3, [5, 10, 15])
      :error

      iex> Change.generate(18, [1, 5, 10])
      {:ok, %{1 => 3, 5 => 1, 10 => 1}}

  """

  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(amount, values) do
    coins = Enum.sort_by(values, &(&1), &>=/2)

    check(amount, coins, %{}, coins)
  end

  defp check(0, coins, map, original) do
    o = Enum.into(Enum.map(original, &{&1,0}), %{})
    { :ok, Map.merge(o, map) }
  end
  defp check(amount, [c|_] = coins, map, o) when amount >= c do
    check(amount - c, coins, Map.update(map, c, 1, fn(e) -> e + 1 end), o)
  end
  defp check(amount, [c|t] = coins, map, o) when amount < c, do: check(amount, t, map, o)

  defp check(_, _, _, _), do: :error
end
