defmodule Rssix.Entries.Entry do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rssix.Sources.Source

  schema "entries" do
    field :content, :string
    field :title, :string
    field :url, :string
    field :read, :boolean, default: false

    belongs_to :source, Source

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:title, :url, :content, :read, :source_id])
    |> unique_constraint(:url)
    |> validate_required([:title, :url, :source_id])
  end
end
