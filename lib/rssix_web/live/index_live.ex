defmodule RssixWeb.IndexLive do
  use RssixWeb, :live_view

  # def render(assigns) do
  #   ~H"""
  #   Hello from live view
  #   """
  # end

  def mount(_params, _session, socket) do
    # {:ok, assign(socket, :temperature, temperature)}
    {:ok, assign(socket, :entries, last_10_entries())}
  end

  defp last_10_entries do
    Rssix.Entries.last_10_entries()
  end
end
