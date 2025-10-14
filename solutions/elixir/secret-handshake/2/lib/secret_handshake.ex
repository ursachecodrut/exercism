defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    [8, 4, 2, 1, 16]
    |> Enum.map(&Bitwise.band(&1, code))
    |> Enum.filter(fn x -> x != 0 end)
    |> Enum.reduce([], &action/2)
  end

  @spec action(code :: integer(), bits :: list(String.t())) :: list(String.t())
  defp action(1, bits), do: ["wink" | bits]
  defp action(2, bits), do: ["double blink" | bits]
  defp action(4, bits), do: ["close your eyes" | bits]
  defp action(8, bits), do: ["jump" | bits]
  defp action(16, bits), do: Enum.reverse(bits)
  defp action(_, bits), do: bits
end
