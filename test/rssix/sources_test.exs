defmodule Rssix.SourcesTest do
  use Rssix.DataCase

  alias Rssix.Sources

  describe "sources" do
    alias Rssix.Sources.Source

    import Rssix.SourcesFixtures

    @invalid_attrs %{title: nil, url: nil}

    test "list_sources/0 returns all sources" do
      source = source_fixture()
      assert Sources.list_sources() == [source]
    end

    test "get_source!/1 returns the source with given id" do
      source = source_fixture()
      assert Sources.get_source!(source.id) == source
    end

    test "create_source/1 with valid data creates a source" do
      valid_attrs = %{title: "some title", url: "some url"}

      assert {:ok, %Source{} = source} = Sources.create_source(valid_attrs)
      assert source.title == "some title"
      assert source.url == "some url"
    end

    test "create_source/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sources.create_source(@invalid_attrs)
    end

    test "update_source/2 with valid data updates the source" do
      source = source_fixture()
      update_attrs = %{title: "some updated title", url: "some updated url"}

      assert {:ok, %Source{} = source} = Sources.update_source(source, update_attrs)
      assert source.title == "some updated title"
      assert source.url == "some updated url"
    end

    test "update_source/2 with invalid data returns error changeset" do
      source = source_fixture()
      assert {:error, %Ecto.Changeset{}} = Sources.update_source(source, @invalid_attrs)
      assert source == Sources.get_source!(source.id)
    end

    test "delete_source/1 deletes the source" do
      source = source_fixture()
      assert {:ok, %Source{}} = Sources.delete_source(source)
      assert_raise Ecto.NoResultsError, fn -> Sources.get_source!(source.id) end
    end

    test "change_source/1 returns a source changeset" do
      source = source_fixture()
      assert %Ecto.Changeset{} = Sources.change_source(source)
    end
  end
end
