defmodule TopSecret do
  def to_ast(string), do: Code.string_to_quoted!(string)

  def decode_secret_message_part({op, _, rest} = ast, acc) when op in [:def, :defp],
    do: {ast, [decode(rest) | acc]}
  def decode_secret_message_part(ast, acc), do: {ast, acc}

  defp decode([{:when, _, rest} | _]), do: decode(rest)
  defp decode([{_, _, nil} | _]), do: ""
  defp decode([{fun, _, args} | _]), do: String.slice(Kernel.to_string(fun), 0, length(args))

  def decode_secret_message(string),
    do:
      string
      |> to_ast
      |> Macro.prewalk([], &decode_secret_message_part/2)
      |> Kernel.elem(1)
      |> Enum.reverse()
      |> Enum.join()
end
