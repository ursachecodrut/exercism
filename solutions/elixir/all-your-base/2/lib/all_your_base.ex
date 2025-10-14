defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, input_base, _) when input_base <= 1, do: {:error, "input base must be >= 2"}
  def convert(_, _, output_base) when output_base <= 1, do: {:error, "output base must be >= 2"}
  def convert([], _, _), do: {:ok, [0]}

  def convert(digits, input_base, output_base) do
    cond do
      Enum.any?(digits, &(&1 < 0 or &1 >= input_base)) ->
        {:error, "all digits must be >= 0 and < input base"}

      true ->
        {
          :ok,
          digits
          |> digits_to_integer(input_base)
          |> integer_to_digits(output_base, [])
        }
    end
  end

  @spec digits_to_integer(list(), pos_integer()) :: pos_integer()
  defp digits_to_integer(digits, base) do
    digits
    |> Enum.reverse()
    |> Enum.with_index(0)
    |> Enum.reduce(0, fn {digit, index}, acc ->
      acc + digit * base ** index
    end)
  end

  @spec integer_to_digits(integer(), pos_integer(), list()) :: list
  defp integer_to_digits(0, _, acc), do: acc

  defp integer_to_digits(number, base, acc) do
    integer_to_digits(div(number, base), base, [rem(number, base) | acc])
  end
end
