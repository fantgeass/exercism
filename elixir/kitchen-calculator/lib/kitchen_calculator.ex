defmodule KitchenCalculator do
  def get_volume({_, volume}) do
    volume
  end

  def to_milliliter({unit, volume}) do
    {:milliliter, volume * unit_ml(unit)}
  end

  def from_milliliter({:milliliter, volume}, unit) do
    {unit, volume / unit_ml(unit)}
  end

  def convert({:milliliter, _} = ml_pair, unit), do: from_milliliter(ml_pair, unit)

  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter()
    |> from_milliliter(unit)
  end

  defp unit_ml(:cup), do: 240
  defp unit_ml(:fluid_ounce), do: 30
  defp unit_ml(:teaspoon), do: 5
  defp unit_ml(:tablespoon), do: 15
  defp unit_ml(:milliliter), do: 1
end
