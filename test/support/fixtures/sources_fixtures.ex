defmodule Rssix.SourcesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rssix.Sources` context.
  """

  @doc """
  Generate a source.
  """
  def source_fixture(attrs \\ %{}) do
    {:ok, source} =
      attrs
      |> Enum.into(%{
        title: "some title",
        url: "some url"
      })
      |> Rssix.Sources.create_source()

    source
  end
end
