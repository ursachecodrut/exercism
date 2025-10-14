defmodule Year do
  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400
  """
  def leap_year?(year) do
    cond do
      rem(year, 4) === 0 && rem(year, 100) !== 0 -> true
      rem(year, 400) === 0 -> true
      true -> false
    end
  end
end
