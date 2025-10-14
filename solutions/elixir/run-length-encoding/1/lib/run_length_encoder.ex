defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    graphemes = String.graphemes(string)
    build_encoded_string(graphemes, 1, "")
  end

  def build_encoded_string([], count, acc), do: acc <> integer_to_counter(count)

  def build_encoded_string([c1 | []], count, acc), do: acc <> c1 <> integer_to_counter(count)

  def build_encoded_string([c1 | [c2 | tail]], count, acc) when c1 == c2 do
    build_encoded_string([c2 | tail], count + 1, acc)
  end

  def build_encoded_string([c1 | [c2 | tail]], count, acc) when c1 != c2 do
    build_encoded_string([c2 | tail], 1, acc <> c1 <> integer_to_counter(count))
  end

  def integer_to_counter(1), do: ""
  def integer_to_counter(num), do: Integer.to_string(num)

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    graphemes = String.graphemes(string)
    build_decoded_string(graphemes, "")
  end

  defp build_decoded_string([], acc), do: acc
  defp build_decoded_string([c | []], acc), do: acc <> c

  defp build_decoded_string([c1 | [c2 | tail]], acc) do
    case(Integer.parse(c2)) do
      :error -> build_decoded_string([c2 | tail], acc <> c1)
      {count, _} -> build_decoded_string(tail, acc <> String.duplicate(c1, count))
    end
  end
end
