defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase()
    |> String.to_charlist()
    |> Enum.map(&point/1)
    |> IO.inspect()
    |> Enum.sum()
  end
  
  def point(?A), do: 1
  def point(?E), do: 1
  def point(?I), do: 1
  def point(?O), do: 1
  def point(?U), do: 1
  def point(?L), do: 1
  def point(?N), do: 1
  def point(?R), do: 1
  def point(?S), do: 1
  def point(?T), do: 1

  def point(?D), do: 2
  def point(?G), do: 2

  def point(?B), do: 3
  def point(?C), do: 3
  def point(?M), do: 3
  def point(?P), do: 3

  def point(?F), do: 4
  def point(?H), do: 4
  def point(?V), do: 4
  def point(?W), do: 4
  def point(?Y), do: 4

  def point(?K), do: 5

  def point(?J), do: 8
  def point(?X), do: 8

  def point(?Q), do: 10
  def point(?Z), do: 10
  def point(_), do: 0

end
