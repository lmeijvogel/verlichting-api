defmodule MyZwaveApi.Lights do

  def get_lights do
    MyZwaveApi.Backend.get("/nodes").json
  end

  def set_level(node_id, level) do
    url = "/nodes/#{node_id}/dim/#{level}"

    response = MyZwaveApi.Backend.post(url, "")

    if response.status_code == 200 do
      {
        :ok
      }
    else
      {
        :error
      }
    end
  end
end
