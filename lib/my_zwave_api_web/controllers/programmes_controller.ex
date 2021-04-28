defmodule MyZwaveApiWeb.ProgrammesController do
  use MyZwaveApiWeb, :controller

  def index(conn, _params) do
    {:ok, programmes} = MyZwaveApi.Programmes.get_programmes

    render(conn, "index.json", programmes: programmes["programmes"])
  end

  def current(conn, _params) do
    {:ok, programme } = MyZwaveApi.Programmes.get_current_programme

    render(conn, "programme_id.json", programme: programme["programme"])
  end

  def start(conn, params) do
    programme_name = params["programme_name"]
    programme_name_valid = Regex.match?(~r/^[a-z_\-]+$/, programme_name)

    if (programme_name_valid) do
      {:ok, started_programme_name} = MyZwaveApi.Programmes.start_programme(programme_name)

      render(conn, "start_success.json", programme_name: started_programme_name)
    else
      conn
        |> put_status(:bad_request)
        |> render("start_error.json", error: "Invalid programme name")
    end
  end
end
