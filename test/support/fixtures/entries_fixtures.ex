defmodule Rssix.EntriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rssix.Entries` context.
  """

  @doc """
  Generate a entry.
  """
  def entry_fixture(attrs \\ %{}) do
    {:ok, entry} =
      attrs
      |> Enum.into(%{
        content: "some content",
        title: "some title",
        url: "some url"
      })
      |> Rssix.Entries.create_entry()

    entry
  end
end
