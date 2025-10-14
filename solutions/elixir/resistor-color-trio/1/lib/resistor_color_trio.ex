defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @units { :ohms,
    :kiloohms,
    :megaohms,
    :gigaohms
  }

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

  def value(first, second) do
    @color_codes[first] * 10 + @color_codes[second]
  end

  def convert(value) when value >= 0 and value <= 9 do
    {rem(value, 3), elem(@units, div(value, 3))}
  end 

  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label([fist | [second | [third | _]]]) do
    {power, unit} = convert(@color_codes[third])
    value = value(fist, second) * :math.pow(10, power)
    {value, unit}
  end
end
