defmodule Rssix.Entries do
  @moduledoc """
  The Entries context.
  """

  import Ecto.Query, warn: false
  alias Rssix.Repo

  alias Rssix.Entries.Entry

  # defp unread do
  #   where(read: false)
  # end

  @doc """
  Returns the list of entries.

  ## Examples

      iex> list_unread_entries()
      [%Entry{}, ...]

  """
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

  @doc """
  Gets a single entry.

  Raises `Ecto.NoResultsError` if the Entry does not exist.

  ## Examples

      iex> get_entry!(123)
      %Entry{}

      iex> get_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_entry!(id), do: Repo.get!(Entry, id)

  @doc """
  Creates a entry.

  ## Examples

      iex> create_entry(%{field: value})
      {:ok, %Entry{}}

      iex> create_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_entry(attrs \\ %{}) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a entry.

  ## Examples

      iex> update_entry(entry, %{field: new_value})
      {:ok, %Entry{}}

      iex> update_entry(entry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_entry(%Entry{} = entry, attrs) do
    entry
    |> Entry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a entry.

  ## Examples

      iex> delete_entry(entry)
      {:ok, %Entry{}}

      iex> delete_entry(entry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_entry(%Entry{} = entry) do
    Repo.delete(entry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking entry changes.

  ## Examples

      iex> change_entry(entry)
      %Ecto.Changeset{data: %Entry{}}

  """
  def change_entry(%Entry{} = entry, attrs \\ %{}) do
    Entry.changeset(entry, attrs)
  end

  # def count(entry_id: entry_id) do
  #   query =
  #     from entry in Entry,
  #       where: entry.user_id == ^user_id

  #   Repo.aggregate(query, :sum, :amount)
  # end
end
