defmodule BirdCount do
  def today([]), do: nil
  def today(list), do: hd(list)

  def increment_day_count([]), do: [1]
  def increment_day_count([h | t]), do: [h + 1 | t]

  def has_day_without_birds?(list) do
    0 in list
  end

  def total(list) do
    Enum.sum(list)
  end

  def busy_days(list) do
    Enum.count(list, &(&1 >= 5))
  end
end
