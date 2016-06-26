defmodule BinarySearch do
  @doc """
    Searches for a key in the list using the binary search algorithm.
    It returns :not_found if the key is not in the list.
    Otherwise returns the tuple {:ok, index}.

    ## Examples

      iex> BinarySearch.search([], 2)
      :not_found

      iex> BinarySearch.search([1, 3, 5], 2)
      :not_found

      iex> BinarySearch.search([1, 3, 5], 5)
      {:ok, 2}

  """

  @spec search(Enumerable.t, integer) :: {:ok, integer} | :not_found
  def search(list, key) do
    if Enum.sort(list) == list do
      do_search(list |> Enum.with_index, key)
    else
      raise ArgumentError, "expected list to be sorted"
    end
  end

  def do_search([{key, index}], key), do: {:ok, index}
  def do_search([], _), do: :not_found
  def do_search([{_}], _), do: :not_found
  def do_search(list, key) do
    { a, b } = Enum.split(list, div(length(list), 2))
    { e, i } = hd(b)

    cond do
      key == e -> i
      key < e -> do_search(a, key)
      key > e -> do_search(b, key)
    end
  end
end
