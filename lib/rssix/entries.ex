defmodule Rssix.Entries do
  import Ecto.Query, warn: false
  alias Rssix.Repo

  alias Rssix.Entries.Entry
  def list_unread_entries do
    from(e in Entry, where: e.read == false)
    |> order_by({:desc, :read})
    |> Repo.all()
  end

  def last_10_unread_entries do
    from(e in Entry, where: e.read == false)
    |> order_by({:desc, :read})
    |> limit(10)
    |> Repo.all()
  end

  def list_entries do
    Repo.all(Entry)
    |> order_by({:desc, :read})
  end

  def last_10_entries do
    Repo.all(Entry)
    |> order_by({:desc, :read})
    |> limit(10)
  end

  def read_entry(id) do
    entry = Repo.get!(Entry, id)
    Repo.update(Entry.changeset(entry, %{read: true}))
  end

  def get_entry!(id), do: Repo.get!(Entry, id)

  def create_entry(attrs \\ %{}) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> Repo.insert()
  end

  def update_entry(%Entry{} = entry, attrs) do
    entry
    |> Entry.changeset(attrs)
    |> Repo.update()
  end

  def delete_entry(%Entry{} = entry) do
    Repo.delete(entry)
  end

  def change_entry(%Entry{} = entry, attrs \\ %{}) do
    Entry.changeset(entry, attrs)
  end
end
