defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(""), do: true

  def check_brackets(str), do: check_brackets(str, [])

  defp check_brackets("", []), do: true
  defp check_brackets("", _), do: false

  defp check_brackets(<<c, str::binary>>, stack) when c in ~c"([{" do
    check_brackets(str, [c | stack])
  end

  defp check_brackets(<<?], str::binary>>, [?[ | brackets]), do: check_brackets(str, brackets)
  defp check_brackets(<<?}, str::binary>>, [?{ | brackets]), do: check_brackets(str, brackets)
  defp check_brackets(<<?), str::binary>>, [?( | brackets]), do: check_brackets(str, brackets)

  defp check_brackets(<<c, _::binary>>, _) when c in ~c"]})", do: false
  defp check_brackets(<<_, str::binary>>, brackets), do: check_brackets(str, brackets)
end
