defmodule RssixWeb.IndexLive do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use RssixWeb, :live_view
  use Phoenix.LiveView

  # def render(assigns) do
  #   ~H"""
  #   Hello from live view
  #   """
  # end

  def mount(_params, _session, socket) do
    # {:ok, assign(socket, :temperature, temperature)}
    {:ok, socket}
  end
end
