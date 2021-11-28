defmodule Rssix.EntriesUpdater do
  use GenServer
  # client

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  # server

  @impl true
  def init(_args) do
    Process.register(self(), __MODULE__)

    Process.send(self(), :fetch_all, [])

    {:ok,
     %{
       entries: []
     }}
  end

  @impl true
  def handle_info(:fetch_all, state) do
    sources = Rssix.Repo.all(Rssix.Sources.Source)

    sources
    |> Enum.map(fn source ->
      case Rssix.Scraper.scrape(source.url) do
        {:ok, parsed_entries} ->
          IO.puts("got response " <> source.url)

          try do
            parsed_entries
            |> Enum.map(fn e ->
              IO.inspect(e)
              Rssix.Entries.Entry.changeset(%Rssix.Entries.Entry{}, e)
            end)
            |> Enum.map(&Rssix.Repo.insert(&1))
          rescue
            e ->
              IO.puts("failed to insert entries for " <> source.url)
              IO.inspect(e)
          end

        {:error, error} ->
          IO.puts("error getting " <> source.url)
          IO.inspect(error)
      end
    end)

    Process.send_after(self(), :fetch_all, 1_000 * 60 * 30)

    {:noreply, state}
  end

  @impl true
  def handle_info({:fetch, url}, state) do
    case Rssix.Scraper.scrape(url) do
      {:ok, parsed_entries} ->
        IO.puts("got response " <> url)

        try do
          parsed_entries
          |> Enum.map(fn e ->
            IO.inspect(e)
            Rssix.Entries.Entry.changeset(%Rssix.Entries.Entry{}, e)
          end)
          |> Enum.map(&Rssix.Repo.insert(&1))
        rescue
          e ->
            IO.puts("failed to insert entries for " <> url)
            IO.inspect(e)
        end

      {:error, error} ->
        IO.puts("error getting " <> url)
        IO.inspect(error)
    end

    {:noreply, state}
  end
end
