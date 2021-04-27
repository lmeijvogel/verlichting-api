defmodule MyZwaveApiWeb.Router do
  use MyZwaveApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MyZwaveApiWeb do
    pipe_through :browser

    get "/csrf_token", PageController, :csrf_token
  end

  scope "/programmes", MyZwaveApiWeb do
    pipe_through :api

    get "/", ProgrammesController, :index
    get "/current", ProgrammesController, :current
    post "/:programme_name/start", ProgrammesController, :start
  end

  scope "/lights", MyZwaveApiWeb do
    pipe_through :api

    get "/", LightsController, :index
    post "/:node_id/level/:level", LightsController, :level
  end

  scope "/main_switch", MyZwaveApiWeb do
    pipe_through :api

    get "/", MainSwitchController, :index
    post "/", MainSwitchController, :set
  end

  scope "/vacation_mode", MyZwaveApiWeb do
    pipe_through :api

    get "/", VacationModeController, :index
    post "/", VacationModeController, :set
  end
  # Other scopes may use custom stacks.
  # scope "/api", MyZwaveApiWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: MyZwaveApiWeb.Telemetry
    end
  end
end
