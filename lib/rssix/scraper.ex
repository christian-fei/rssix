defmodule Rssix.Scraper do
  def scrape(url) do
    case Tesla.get(url) do
      {:ok, response} ->
        case Rssix.RssParser.parse_body(response.body) do
          nil ->
            {:error, :unsupported}

          parsed_entries ->
            {:ok, parsed_entries}
        end

      {:error, error} ->
        IO.puts("error getting " <> url)
        IO.inspect(error)
        {:error, error}
    end
  end
end
