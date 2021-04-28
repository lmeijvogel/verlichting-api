defmodule MyZwaveApi.Programmes do
  @moduledoc """
  MyZwaveApi keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def get_programmes do
    MyZwaveApi.Backend.get("/programmes").json
  end

  def get_current_programme do
    MyZwaveApi.Backend.get("/programmes/current").json
  end

  def start_programme(programme_name) do
    url = "/programmes/#{programme_name}/start"

    response = MyZwaveApi.Backend.post(url, "")

    if response.status_code == 200 do
      {
        :ok,
        programme_name
      }
    else
      {
        :error
      }
    end
  end
end
