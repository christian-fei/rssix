defmodule Rssix.Sources.Source do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sources" do
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(source, attrs) do
    source
    |> cast(attrs, [:title, :url])
    |> validate_required([:title, :url])
  end
end
