defmodule Bob do
  @spec hey(String.t()) :: String.t()

  def hey(input) do
    trimmed = String.trim(input)

    cond do
      silence?(trimmed) and yelling?(trimmed) -> "Calm down, I know what I'm doing!"
      silence?(trimmed) -> "Fine. Be that way!"
      yelling?(trimmed) -> "Whoa, chill out!"
      question?(trimmed) -> "Sure."
      true -> "Whatever."
    end
  end

  defp question?(input), do: String.ends_with?(input, "?")
  defp yelling?(input), do: String.upcase(input) == input
  defp silence?(input), do: String.trim(input) == ""
end
