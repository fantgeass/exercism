defmodule TopSecret do
  def to_ast(string) do
    {:ok, res} = Code.string_to_quoted(string)
    res
  end

  def decode_secret_message_part(node = {a, _, [{_c, _location, nil} | _]}, acc)
      when a in [:def, :defp] do
    {node, ["" | acc]}
  end

  def decode_secret_message_part(
        node = {_, _, [{:when, _, [{c, _location, params} | _]} | _]},
        acc
      ) do
    {node, [to_charlist(c) |> Enum.take(Enum.count(params)) |> to_string | acc]}
  end

  def decode_secret_message_part(node = {a, _b, [{c, _location, params} | _]}, acc)
      when a in [:def, :defp] do
    {node, [to_charlist(c) |> Enum.take(Enum.count(params)) |> to_string | acc]}
  end

  def decode_secret_message_part(node, acc) do
    {node, acc}
  end

  def decode_secret_message(string) do
    data = to_ast(string)
    {_, acc} = Macro.prewalk(data, [], &decode_secret_message_part/2)
    acc |> Enum.reverse() |> Enum.join()
  end
end
