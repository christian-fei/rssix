defmodule RssixWeb.IndexLive do
  use RssixWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket
    |> assign(:entries, Rssix.Entries.last_10_unread_entries())
    |> assign(:sources, Rssix.Sources.list_sources())
    }
  end

  @impl true
  def handle_event("read", %{"id" => id}, socket) do
    {:ok, _} = Rssix.Entries.read_entry(id)

    {:noreply, assign(socket, :entries, Rssix.Entries.last_10_unread_entries())}
  end
end
