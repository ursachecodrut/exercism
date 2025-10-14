defmodule Bob do
  def hey(input) do
    cond do
      String.trim(input) == "" -> "Fine. Be that way!"
      question?(input) and yelling?(input) -> "Calm down, I know what I'm doing!"
      question?(input) -> "Sure."
      yelling?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp question?(input), do: String.ends_with?(String.trim(input), "?")
  defp yelling?(input), do: String.upcase(input) == input and letter?(input)
  defp letter?(input), do: String.upcase(input) != String.downcase(input)
end
