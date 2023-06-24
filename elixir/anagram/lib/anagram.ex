defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """

  @spec char_map(String.t()) :: %{char() => non_neg_integer()}
  defp char_map(word) do
    word
    |> String.downcase()
    |> String.graphemes()
    |> Enum.reduce(%{}, fn c, acc ->
      Map.update(acc, c, 1, &(&1 + 1))
    end)
  end

  @spec anagram?(String.t(), String.t()) :: boolean()
  defp anagram?(word1, word2) do
    String.downcase(word1) != String.downcase(word2) &&
      char_map(word1) == char_map(word2)
  end

  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.filter(&anagram?(base, &1))
  end
end
