defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
    texts
    |> Stream.chunk_every(1) # Chunk into lists of 1 string each
    |> Task.async_stream(__MODULE__, :count_string_frequency, [], max_concurrency: workers)

    |> Enum.reduce(%{}, fn
      {:ok, partial_freq_map}, acc ->
        Map.merge(acc, partial_freq_map, fn _key, v1, v2 -> v1 + v2 end)

      {:exit, reason}, acc ->
        IO.warn("Worker failed: #{inspect(reason)}")
        acc
      _, acc ->
        acc
    end)
  end

  def count_string_frequency(chunk) do
    Enum.reduce(chunk, %{}, fn text, acc ->
      text
      |> String.downcase() 
      |> String.graphemes()
      |> Enum.reduce(acc, fn char, char_acc ->
        case String.match?(char, ~r/^[a-z]$/) do
          true ->
            Map.update(char_acc, char, 1, &(&1 + 1))
          false ->
            char_acc
        end
      end)
    end)
  end
end
