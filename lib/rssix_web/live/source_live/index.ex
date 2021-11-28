defmodule RssixWeb.SourceLive.Index do
  use RssixWeb, :live_view

  alias Rssix.Sources
  alias Rssix.Sources.Source

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :sources, list_sources())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Source")
    |> assign(:source, Sources.get_source!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Source")
    |> assign(:source, %Source{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Sources")
    |> assign(:source, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    source = Sources.get_source!(id)
    {:ok, _} = Sources.delete_source(source)

    {:noreply, assign(socket, :sources, list_sources())}
  end

  @impl true
  def handle_event("scrape", %{"url" => url}, socket) do
    Process.send(Rssix.EntriesUpdater, {:fetch, url}, [])

    {:noreply, socket}
  end

  defp list_sources do
    Sources.list_sources()
  end
end
