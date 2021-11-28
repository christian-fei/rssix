defmodule Rssix.Repo.Migrations.AlterTableAddReadToEntries do
  use Ecto.Migration

  def change do
    alter table(:entries) do
      add :read, :boolean

    end

  end
end
