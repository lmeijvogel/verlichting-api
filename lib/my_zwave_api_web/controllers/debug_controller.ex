defmodule MyZwaveApiWeb.DebugController do
  use MyZwaveApiWeb, :controller

  def heal_network(conn, _params) do
    response = MyZwaveApi.Backend.post("/debug/heal_network", "")

    if response.status_code == 200 do
      json(conn, %{state: "Command sent"})
    else
      conn
      |> put_status(500)
      |> json(%{ error: "Error sending request to ZWave backend" })
    end
  end
end
