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

    for source <- sources do
      case Rssix.Scraper.scrape(source.url) do
        {:ok, parsed_entries} ->
          IO.puts("got response " <> source.url)

          parsed_entries
          |> Enum.map(fn e ->
            Rssix.Entries.Entry.changeset(%Rssix.Entries.Entry{}, e)
          end)
          |> Enum.map(&Rssix.Repo.insert(&1))

        {:error, error} ->
          IO.puts("error getting " <> source.url)
          IO.inspect(error)
      end
    end

    Process.send_after(self(), :fetch_all, 1_000 * 60 * 30)

    {:noreply, state}
  end
end
