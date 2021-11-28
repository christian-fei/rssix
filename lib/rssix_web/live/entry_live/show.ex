defmodule RssixWeb.EntryLive.Show do
  use RssixWeb, :live_view

  alias Rssix.Entries

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    Rssix.Entries.read_entry(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:entry, Entries.get_entry!(id))
     |> assign(:entries, last_10_unread_entries())}
  end

  @impl true
  def handle_event("read", %{"id" => id}, socket) do
    {:ok, _} = Rssix.Entries.read_entry(id)

    {:noreply, assign(socket, :entries, last_10_unread_entries())}
  end

  defp page_title(:show), do: "Show Entry"
  defp page_title(:edit), do: "Edit Entry"

  defp last_10_unread_entries do
    Rssix.Entries.last_10_unread_entries()
  end
end
