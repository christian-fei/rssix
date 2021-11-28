defmodule Rssix.Repo.Migrations.CreateSources do
  use Ecto.Migration

  def change do
    create table(:sources) do
      add :title, :string
      add :url, :string

      timestamps()
    end
  end
end
