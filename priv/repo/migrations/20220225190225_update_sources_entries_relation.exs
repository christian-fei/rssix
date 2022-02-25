defmodule Rssix.Repo.Migrations.UpdateSourcesEntriesRelation do
  use Ecto.Migration

  def change do
    alter table(:entries) do
      add :source_id, references(:sources)
    end
  end
end
