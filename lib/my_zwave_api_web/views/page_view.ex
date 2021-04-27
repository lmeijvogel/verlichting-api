defmodule MyZwaveApiWeb.PageView do
  use MyZwaveApiWeb, :view

  def render("csrf_token.json", %{csrf_token: csrf_token}) do
    %{
      csrf_token: csrf_token
    }
  end
end
