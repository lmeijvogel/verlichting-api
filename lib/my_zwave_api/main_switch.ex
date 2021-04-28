defmodule MainSwitch do
  def get_state do
    MyZwaveApi.Backend.get("/main_switch/enabled").json
  end

  def set_state(new_state) do
    state_for_backend = if new_state do
      "on"
    else
      "off"
    end

    url = "/main_switch/enabled/#{state_for_backend}"

    MyZwaveApi.Backend.post(url, "").json
  end
end
