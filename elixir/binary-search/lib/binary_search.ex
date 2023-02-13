defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """


  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    binary_search(numbers, key, 0, tuple_size(numbers) - 1)
  end

  @spec binary_search(tuple, integer, integer, integer) :: {:ok, integer} | :not_found
  defp binary_search(_, _, s, e) when s > e, do: :not_found
  defp binary_search(numbers, key, s, e) do
    mid = s + div(e - s, 2)

    cond do 
      key === elem(numbers, mid) -> {:ok, mid}
      key < elem(numbers, mid) -> binary_search(numbers, key, s, mid - 1)
      key > elem(numbers, mid) -> binary_search(numbers, key, mid + 1, e)
    end
  end
end
