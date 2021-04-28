defmodule MyZwaveApiWeb.MainSwitchView do
  def render("index.json", %{state: state}) do
    %{
      state: state
    }
  end

  def render("set.json", %{state: state}) do
    %{
      state: state
    }
  end
end
