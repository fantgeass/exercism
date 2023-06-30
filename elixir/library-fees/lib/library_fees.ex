defmodule LibraryFees do
  def datetime_from_string(string) do
    {:ok, datetime} = NaiveDateTime.from_iso8601(string)
    datetime
  end

  def before_noon?(datetime) do
    datetime
    |> NaiveDateTime.to_time()
    |> Time.diff(~T[12:00:00])
    |> Kernel.<(0)
  end

  def return_date(checkout_datetime) do
    days = if before_noon?(checkout_datetime), do: 28, else: 29

    Date.add(checkout_datetime, days)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    days_diff = Date.diff(actual_return_datetime, planned_return_date)

    if days_diff > 0, do: days_diff, else: 0
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week()
    |> Kernel.===(1)
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = datetime_from_string(checkout)
    return_datetime = datetime_from_string(return)

    fee =
      checkout_datetime
      |> return_date()
      |> days_late(return_datetime)
      |> Kernel.*(rate)

    if monday?(return_datetime), do: trunc(fee * 0.5), else: fee
  end
end
