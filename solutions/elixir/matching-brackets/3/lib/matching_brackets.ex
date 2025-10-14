defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(""), do: true

  def check_brackets(str) do
    str
    |> String.to_charlist()
    |> check_brackets([])
  end

  @spec check_brackets(charlist(), charlist()) :: boolean
  defp check_brackets([], []), do: true
  defp check_brackets([], _), do: false

  defp check_brackets([?{ | chars], stack), do: check_brackets(chars, [?{ | stack])

  defp check_brackets([?[ | chars], stack), do: check_brackets(chars, [?[ | stack])
  defp check_brackets([?( | chars], stack), do: check_brackets(chars, [?( | stack])

  defp check_brackets([?} | _], []), do: false
  defp check_brackets([?] | _], []), do: false
  defp check_brackets([?) | _], []), do: false

  defp check_brackets([?} | chars], [?{ | stack]), do: check_brackets(chars, stack)
  defp check_brackets([?] | chars], [?[ | stack]), do: check_brackets(chars, stack)
  defp check_brackets([?) | chars], [?( | stack]), do: check_brackets(chars, stack)

  defp check_brackets([c | chars], stack), do: check_brackets(chars, [c | stack])
end
