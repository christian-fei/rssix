defmodule RssixWeb.IndexLive do
  use RssixWeb, :live_view

  # def render(assigns) do
  #   ~H"""
  #   Hello from live view
  #   """
  # end
  @impl true

  def mount(_params, _session, socket) do
    # {:ok, assign(socket, :temperature, temperature)}
    {:ok, assign(socket, :entries, last_10_entries())}
  end

  @impl true
  def handle_event("read", %{"id" => id}, socket) do
    {:ok, _} = Rssix.Entries.read_entry(id)

    {:noreply, assign(socket, :entries, last_10_entries())}
  end

  defp last_10_entries do
    Rssix.Entries.last_10_entries()
  end
end
