defmodule MyZwaveApiWeb.LightsController do
  use MyZwaveApiWeb, :controller

  def index(conn, _params) do
    { :ok, lights } = MyZwaveApi.Lights.get_lights

    render(conn, "lights.json", lights: lights)
  end

  def level(conn, params) do
    { node_id, "" } = Integer.parse(params["node_id"])
    { level, "" } = Integer.parse(params["level"])

    case MyZwaveApi.Lights.set_level(node_id, level) do
      { :ok } -> render(conn, "level_success.json", level: level)
      { :error } ->
        conn
          |> put_status(503)
          |> render("level_error.json", %{})
    end
  end
end
