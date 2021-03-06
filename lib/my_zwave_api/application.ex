defmodule MyZwaveApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MyZwaveApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: MyZwaveApi.PubSub},
      {Redix, host: System.get_env("REDIS_HOST"), name: :redix},
      # Start the Endpoint (http/https)
      MyZwaveApiWeb.Endpoint,
      {MyZwaveApi.Backend, System.fetch_env!("DRIVER_HOST")}
      # Start a worker by calling: MyZwaveApi.Worker.start_link(arg)
      # {MyZwaveApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MyZwaveApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MyZwaveApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
