defmodule Username do
  def sanitize(username) do
    username
    |> Enum.reduce([], fn
      c, a when c >= ?a and c <= ?z -> [c | a]
      c, a when c === ?_ -> [c | a]
      c, a when c === ?ä -> [hd('e'), hd('a') | a]
      c, a when c === ?ö -> [hd('e'), hd('o') | a]
      c, a when c === ?ü -> [hd('e'), hd('u') | a]
      c, a when c === ?ß -> [hd('s'), hd('s') | a]
      _c, a -> a
    end)
    |> Enum.reverse()
  end
end
