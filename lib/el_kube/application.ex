defmodule ElKube.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    topologies = Application.get_env(:libcluster, :topologies)

    children = [
      {Cluster.Supervisor, [topologies, [name: ElKube.ClusterSupervisor]]},
      # Start the Ecto repository
      ElKube.Repo,
      # Start the Telemetry supervisor
      ElKubeWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ElKube.PubSub},
      # Start the Endpoint (http/https)
      ElKubeWeb.Endpoint
      # Start a worker by calling: ElKube.Worker.start_link(arg)
      # {ElKube.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElKube.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ElKubeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
