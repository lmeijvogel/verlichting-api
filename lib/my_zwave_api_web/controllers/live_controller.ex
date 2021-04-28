defmodule MyZwaveApiWeb.LiveController do
  use MyZwaveApiWeb, :controller

  def get(conn, _params) do
    json(conn, %{state: MyZwaveApi.Backend.live?})
  end

  def set(conn, params) do
    new_state = params["new_state"] == "true"

    MyZwaveApi.Backend.set_live(new_state)

    json(conn, %{state: new_state})
  end
end
