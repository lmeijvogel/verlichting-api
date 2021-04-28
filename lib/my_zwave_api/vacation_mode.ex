defmodule VacationMode do
  def get_state do
    response = HTTPoison.get!(base_url)

    Poison.decode(response.body)
  end

  def enable(start_time, end_time) do
    url = "#{base_url}/on/#{start_time}/#{end_time}"

    response = HTTPoison.post!(url, "")

    Poison.decode(response.body)
  end

  def disable do
    url = "#{base_url}/off"

    response = HTTPoison.post!(url, "")

    Poison.decode(response.body)
  end

  def base_url do
    "http://#{Application.fetch_env!(:my_zwave_api, :driver_host)}/vacation_mode"
  end
end
