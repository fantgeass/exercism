defmodule LogParser do
  def valid_line?(line) do
    Regex.match?(~r/^(\[){1}(ERROR|DEBUG|WARNING|INFO){1}(\]){1}/, line)
  end

  def split_line(line) do
    String.split(line, ~r/<[~*=-]*>/)
  end

  def remove_artifacts(line) do
    String.replace(line, ~r/(?i)end-of-line\d+/, "")
  end

  defp prefix(nil), do: ""
  defp prefix([_, user]), do: "[USER] #{user} "

  def tag_with_user_name(line) do
    prefix(Regex.run(~r/User\s+(\S+)/u, line)) <> line
  end
end
