defmodule RssixWeb.SourceLive.FormComponent do
  use RssixWeb, :live_component

  alias Rssix.Sources

  @impl true
  def update(%{source: source} = assigns, socket) do
    changeset = Sources.change_source(source)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"source" => source_params}, socket) do
    changeset =
      socket.assigns.source
      |> Sources.change_source(source_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"source" => source_params}, socket) do
    save_source(socket, socket.assigns.action, source_params)
  end

  defp save_source(socket, :edit, source_params) do
    case Sources.update_source(socket.assigns.source, source_params) do
      {:ok, _source} ->
        {:noreply,
         socket
         |> put_flash(:info, "Source updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_source(socket, :new, source_params) do
    case Sources.create_source(source_params) do
      {:ok, _source} ->
        {:noreply,
         socket
         |> put_flash(:info, "Source created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
