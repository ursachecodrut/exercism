defmodule LibraryFees do
  @noon ~T[12:00:00]

  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime
    |> NaiveDateTime.to_time()
    |> Time.compare(@noon) == :lt
  end

  def return_date(checkout_datetime) do
    checkout_datetime
    |> NaiveDateTime.to_date()
    |> Date.add(days_to_add(checkout_datetime))
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> NaiveDateTime.to_date()
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    return_datetime = datetime_from_string(return)

    days_late =
      checkout
      |> datetime_from_string()
      |> return_date()
      |> days_late(return_datetime)

    fee = rate * days_late

    if monday?(return_datetime) do
      div(fee, 2)
    else
      fee
    end
  end

  defp days_to_add(datetime) do
    case before_noon?(datetime) do
      true -> 28
      false -> 29
    end
  end
end
