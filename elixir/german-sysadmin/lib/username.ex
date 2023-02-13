defmodule Username do
  defguard is_lowercase(char) when char >= ?a and char <= ?z
  defguard is_underscore(char) when char == ?_

  @spec sanitize(username :: [char()]) :: [char()]
  def sanitize(username) do
    username
    |> Enum.flat_map(&translate/1)
    |> Enum.filter(&(is_lowercase(&1) or is_underscore(&1)))
  end
  
  @spec translate(char :: char()) :: [char()]
  defp translate(char) do
    case char do
      ?ä -> 'ae'
      ?ö -> 'oe'
      ?ü -> 'ue'
      ?ß -> 'ss'
      _ -> [char]
    end
  end
end
