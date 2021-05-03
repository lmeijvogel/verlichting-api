defmodule MyZwaveApiWeb.ProgrammesController do
  use MyZwaveApiWeb, :controller

  def index(conn, _params) do
    {:ok, programmes} = MyZwaveApi.Programmes.get_programmes
    {:ok, current } = MyZwaveApi.Programmes.get_current_programme

    json(conn, %{
      programmes: Enum.map(programmes["programmes"], fn programme -> %{
        id: programme["name"],
        name: programme["displayName"]
      } end),
      current: current["programme"]
    })
  end

  def current(conn, _params) do
    {:ok, programme } = MyZwaveApi.Programmes.get_current_programme

    json(conn, %{id: programme["programme"]})
  end

  def start(conn, params) do
    programme_name = params["programme_name"]
    programme_name_valid = Regex.match?(~r/^[a-z_\-]+$/, programme_name)

    if (programme_name_valid) do
      {:ok, started_programme_name} = MyZwaveApi.Programmes.start_programme(programme_name)

      json(conn, %{ success: true, programme: started_programme_name})
    else
      conn
        |> put_status(:bad_request)
        |> json(%{ success: false, error: "Invalid programme name"})
    end
  end
end
