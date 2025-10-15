defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
    tasks = Enum.map(1..workers, fn _ -> [] end)

    worker_texts =
      texts
      |> Enum.with_index()
      |> Enum.reduce(tasks, fn {text, index}, acc ->
        worker_num = rem(index, workers)
        worker_texts = Enum.at(acc, worker_num)
        List.replace_at(acc, worker_num, [text | worker_texts])
      end)

    worker_texts
    |> Enum.map(&Task.async(fn -> count_frequency_of_texts(&1) end))
    |> Enum.map(&Task.await/1)
    |> Enum.reduce(%{}, fn count_map, acc -> 
      Map.merge(acc, count_map, fn _k, v1, v2 ->
        v1 + v2
      end)
    end)
  end

  def count_frequency_of_texts(texts) do
    texts
    |> Enum.map(&count_frequency/1)
    |> Enum.reduce(%{}, fn count_map, acc -> 
      Map.merge(acc, count_map, fn _k, v1, v2 ->
        v1 + v2
      end)
    end)
  end

  def count_frequency(text) do
    text
    |> String.replace(~r/[^[:alpha:]]/, "")
    |> String.graphemes()
    |> Enum.reduce(%{}, fn char, acc ->
      count = Map.get(acc, char, 0)
      Map.put(acc, char, count + 1)
    end)
  end
end
