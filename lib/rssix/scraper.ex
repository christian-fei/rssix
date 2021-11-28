defmodule Rssix.Scraper do
  import SweetXml

  def scrape(url) do
    case Tesla.get(url) do
      {:ok, response} ->
        IO.puts("got response " <> url)
        parsed_entries = parse_entries(response.body)
        {:ok, parsed_entries}

      {:error, error} ->
        IO.puts("error getting " <> url)
        IO.inspect(error)
        {:error, error}
    end
  end

  defp parse_entries(xml) do
    SweetXml.parse(xml)
    |> xpath(~x"//entry"l,
      title: ~x"./title/text()",
      content: ~x"./content/text()",
      url: ~x"./link/@href"
    )
    |> Enum.map(fn e ->
      %{
        title: e.title |> List.to_string(),
        url: e.url |> List.to_string(),
        content: e.content |> List.to_string()
      }
    end)
  end
end
