defmodule Rssix.Scraper do
  def scrape(url) do
    t = Task.async(fn -> do_scrape(url) end)
    Task.await(t, 30_000)
  end

  defp do_scrape(url) do
    case Tesla.get(url) do
      {:ok, response} ->
        IO.puts("success scraping " <> url)
        {:ok, Rssix.RssParser.parse_body(response.body)}

      {:error, error} ->
        IO.puts("error getting " <> url)
        IO.inspect(error)
        {:error, error}
    end
  end
end
