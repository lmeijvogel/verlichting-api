defmodule MyZwaveApiWeb.MainSwitchController do
  use MyZwaveApiWeb, :controller

  def index(conn, _params) do
    { :ok, state } = MainSwitch.get_state

    render(conn, "index.json", %{ state: state["state"] })
  end

  def set(conn, params) do
    case MainSwitch.set_state(params["state"]) do
      {:ok, state } -> render(conn, "set.json", %{ state: state["state"]})
    end
  end
end
