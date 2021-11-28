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
      t = Task.async(fn -> Rssix.Scraper.scrape(source.url) end)
      result = Task.await(t, 30_000)

      case result do
        {:ok, parsed_entries} ->
          parsed_entries
          |> Enum.map(fn e ->
            Rssix.Entries.Entry.changeset(%Rssix.Entries.Entry{}, e)
          end)
          |> Enum.map(&Rssix.Repo.insert(&1))

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
        try do
          parsed_entries
          |> Enum.map(fn e ->
            IO.inspect(e)
            Rssix.Entries.Entry.changeset(%Rssix.Entries.Entry{}, e)
          end)
          |> Enum.map(fn c ->
            case Rssix.Repo.insert(c) do
              {:ok, r} ->
                IO.puts("add entry successful")
                IO.inspect(r)

              {:error, e} ->
                IO.puts("add entry failed")
                IO.inspect(e)
            end
          end)
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
