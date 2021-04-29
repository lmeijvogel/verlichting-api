defmodule VacationMode do
  def get_state do
    response = HTTPoison.get!("/vacation_mode")

    Poison.decode(response.body)
  end

  def enable(start_time, end_time) do
    url = "/vacation_mode/on/#{start_time}/#{end_time}"

    response = HTTPoison.post!(url, "")

    Poison.decode(response.body)
  end

  def disable do
    url = "/vacation_mode/off"

    response = HTTPoison.post!(url, "")

    Poison.decode(response.body)
  end
end
