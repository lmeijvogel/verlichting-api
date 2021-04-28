defmodule MyZwaveApiWeb.VacationModeController do
  use MyZwaveApiWeb, :controller

  def index(conn, _params) do
    { :ok, state } = VacationMode.get_state

    render(conn, "index.json", %{state: state})
  end

  def set(conn, params) do
    new_state = %{ params | "state" => params["state"] == "on" }

    case params do
      %{ "state" => "off" } ->
        VacationMode.disable
        render(conn, "index.json", %{state: new_state})
      %{ "state" => "on",
        "start_time" => start_time,
        "end_time" => end_time
      } ->
        if valid?(start_time) && valid?(end_time) do
          VacationMode.enable(start_time, end_time)
          render(conn, "index.json", %{state: new_state})
        else
          conn
          |> put_status(400)
          |> json(%{ error: "invalid start or end time" })
        end
    end
  end

  def valid?(time) do
    parts = String.split(time, ":")

    case parts do
      [hour_str, minute_str] -> valid_hour_str?(hour_str) && valid_minute_str?(minute_str)
      _ -> false
    end
  end

  def valid_hour_str?(hour_str) do
    { hour, "" } = Integer.parse(hour_str)

    0 <= hour && hour <= 24
  end

  def valid_minute_str?(minute_str) do
    { minute, "" } = Integer.parse(minute_str)

    0 <= minute && minute < 60
  end
end
