defmodule Rssix.Entries.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entries" do
    field :content, :string
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:title, :url, :content])
    |> validate_required([:title, :url, :content])
  end
end
