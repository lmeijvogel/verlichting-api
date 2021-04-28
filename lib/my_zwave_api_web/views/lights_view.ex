defmodule MyZwaveApiWeb.LightsView do
  use MyZwaveApiWeb, :view

  def render("lights.json", %{lights: lights}) do
    %{ lights: render_many(lights["lights"], MyZwaveApiWeb.LightsView, "light.json", as: :light)
    }
  end

  def render("light.json", %{light: light}) do
    base_data = %{
      node_id: light["id"],
      name: light["name"],
      display_name: light["displayName"],
    }

    Map.merge(base_data, dim_or_switch_data(light["values"]["37"], light["values"]["38"]))
  end

  def render("level_success.json", %{level: level}) do
    %{
      success: true,
      level: level
    }
  end

  def dim_or_switch_data(entry37, nil) do
    value = entry37["value"]

    %{ activation_type: "switch", state: value == "true" }
  end

  def dim_or_switch_data(nil, entry38) do
    value = entry38["value"]

    %{ activation_type: "dim", value: value }
  end
end
