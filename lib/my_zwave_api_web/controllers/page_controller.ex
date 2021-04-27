defmodule MyZwaveApiWeb.PageController do
  use MyZwaveApiWeb, :controller

  def csrf_token(conn, _params) do
    render(conn, "csrf_token.json", csrf_token: get_csrf_token())
  end
end
