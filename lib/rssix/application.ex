defmodule Rssix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Rssix.Repo,
      # Start the Telemetry supervisor
      RssixWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Rssix.PubSub},
      # Start the Endpoint (http/https)
      RssixWeb.Endpoint,
      Rssix.EntriesUpdater
      # Start a worker by calling: Rssix.Worker.start_link(arg)
      # {Rssix.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Rssix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RssixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
