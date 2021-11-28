defmodule RssixWeb.IndexLive do
  use RssixWeb, :live_view

  # def render(assigns) do
  #   ~H"""
  #   Hello from live view
  #   """
  # end

  def mount(_params, _session, socket) do
    # {:ok, assign(socket, :temperature, temperature)}
    {:ok, assign(socket, :entries, list_entries())}
  end

  defp list_entries do
    Rssix.Entries.list_entries()
  end
end
