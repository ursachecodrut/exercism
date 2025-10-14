defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """

  @spec char_map(String.t()) :: map()
  def char_map(word) do
    word
    |> String.graphemes()
    |> Enum.reduce(%{}, fn c, acc ->
      if Map.has_key?(acc, c) do
        Map.put(acc, c, Map.get(acc, c) + 1)
      else
        Map.put(acc, c, 1)
      end
    end)
  end

  @spec anagram?(String.t(), String.t()) :: boolean()
  def anagram?(word1, word2) do
    String.downcase(word1) != String.downcase(word2) and char_map(word1) == char_map(word2)
  end

  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.filter(&anagram?(base, &1))
  end
end
