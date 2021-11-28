defmodule Rssix.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :title, :string
      add :url, :string
      add :content, :text

      timestamps()
    end

    create unique_index(:entries, [:url])
  end
end
