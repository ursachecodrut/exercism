defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @color_codes %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do
    [first, second, third] = Enum.take(colors, 3)

    value =
      [first, second]
      |> Enum.map(&@color_codes[&1])
      |> Integer.undigits()

    ohms = value * :math.pow(10, @color_codes[third])

    cond do
      ohms >= 1_000_000_000 -> {ohms / 1_000_000_000, :gigaohms}
      ohms >= 1_000_000 -> {ohms / 1_000_000, :megaohms}
      ohms >= 1_000 -> {ohms / 1_000, :kiloohms}
      true -> {ohms, :ohms}
    end
  end
end
