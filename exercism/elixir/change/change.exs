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
    coins =
      values
      |> Enum.sort_by(&(&1), &>=/2)
      |> Enum.map(&{&1,0})

    check(amount, coins, %{})
  end

  defp check(0, coins, map), do: { :ok, Enum.into(coins, map) }
  defp check(a, [{c, _}|t], map) when a >= c, do: check(rem(a, c), t, put_in(map[c], div(a, c)))
  defp check(a, [{c, _}|t], map) when a < c, do: check(a, t, put_in(map[c], 0))
  defp check(_, _, _), do: :error
end
