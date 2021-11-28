defmodule Rssix.Entries.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entries" do
    field :content, :string
    field :title, :string
    field :url, :string
    field :read, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:title, :url, :content, :read])
    |> unique_constraint(:url)
    |> validate_required([:title, :url])
  end
end
