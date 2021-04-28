defmodule MyZwaveApiWeb.ProgrammesView do
  use MyZwaveApiWeb, :view

  def render("index.json", %{programmes: programmes}) do
    %{
      programmes: render_many(programmes, MyZwaveApiWeb.ProgrammesView, "programme.json", as: :programme)
    }
  end

  def render("programme.json", %{programme: programme}) do
    %{
      id: programme["name"],
      name: programme["displayName"]
    }
  end

  def render("programme_id.json", %{programme: programme}) do
    %{
      id: programme
    }
  end


  def render("start_success.json", %{programme_name: programme_name}) do
    %{
      success: true,
      programme: programme_name
    }
  end

  def render("start_error.json", %{error: error}) do
    %{
      success: false,
      error: error
    }
  end
end
