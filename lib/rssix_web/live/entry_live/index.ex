defmodule RssixWeb.EntryLive.Index do
  use RssixWeb, :live_view

  alias Rssix.Entries
  alias Rssix.Entries.Entry

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :entries, list_unread_entries())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Entry")
    |> assign(:entry, Entries.get_entry!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Entry")
    |> assign(:entry, %Entry{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Entries")
    |> assign(:entry, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    entry = Entries.get_entry!(id)
    {:ok, _} = Entries.delete_entry(entry)

    {:noreply, assign(socket, :entries, list_unread_entries())}
  end

  def handle_event("read", %{"id" => id}, socket) do
    {:ok, _} = Rssix.Entries.read_entry(id)

    {:noreply, assign(socket, :entries, last_10_unread_entries())}
  end

  defp list_unread_entries do
    Entries.list_unread_entries()
  end

  defp last_10_unread_entries do
    Rssix.Entries.last_10_unread_entries()
  end
end
