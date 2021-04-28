defmodule MyZwaveApiWeb.EventsController do
  use MyZwaveApiWeb, :controller

  def index(conn, _params) do
    { :ok, redis_response } = Redix.command(:redix, ["lrange", "zwave_recent_events", "0", "-1"])

    json_result = Enum.map(redis_response, fn line ->
      { :ok, json_line } = Jason.decode(line)
      json_line
    end)

    json(conn, json_result)
  end
end
