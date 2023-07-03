defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) when length(strand2) != length(strand1) do
    {:error, "strands must be of equal length"}
  end

  def hamming_distance(strand1, strand2) do
    {:ok,
     strand1
     |> Enum.zip(strand2)
     |> Enum.filter(fn {a, b} -> a != b end)
     |> length()}
  end
end
