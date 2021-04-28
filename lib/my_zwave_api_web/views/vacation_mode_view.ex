defmodule MyZwaveApiWeb.VacationModeView do
  use MyZwaveApiWeb, :view

  def render("index.json", %{state: state}) do
    case state["state"] do
      true ->
        %{
          meanStartTime: state["meanStartTime"],
          meanEndTime: state["meanEndTime"],
          state: "on"
        }
      false ->
        %{
          state: "off"
        }
    end
  end
end
