defmodule VacationMode do
  def get_state do
    MyZwaveApi.Backend.get("/vacation_mode").json
  end

  def enable(start_time, end_time) do
    MyZwaveApi.Backend.post("/vacation_mode/on/#{start_time}/#{end_time}").json
  end

  def disable do
    MyZwaveApi.Backend.post("/vacation_mode/off").json
  end
end
