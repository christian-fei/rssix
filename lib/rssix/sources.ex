defmodule Rssix.Sources do
  import Ecto.Query, warn: false
  alias Rssix.Repo

  alias Rssix.Sources.Source
  def list_sources do
    Repo.all(Source)
  end

  def get_source!(id), do: Repo.get!(Source, id)

  def get_source_with_entries!(id), do: Repo.get!(Source, id) |> Repo.preload(:entries)

  def create_source(attrs \\ %{}) do
    %Source{}
    |> Source.changeset(attrs)
    |> Repo.insert()
  end

  def update_source(%Source{} = source, attrs) do
    source
    |> Source.changeset(attrs)
    |> Repo.update()
  end

  def delete_source(%Source{} = source) do
    Repo.delete(source)
  end

  def change_source(%Source{} = source, attrs \\ %{}) do
    Source.changeset(source, attrs)
  end
end
