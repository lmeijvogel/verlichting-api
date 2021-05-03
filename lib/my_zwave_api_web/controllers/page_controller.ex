defmodule MyZwaveApiWeb.PageController do
  use MyZwaveApiWeb, :controller

  def csrf_token(conn, _params) do
    json(conn, %{csrf_token: get_csrf_token()})
  end
end
