defmodule Rssix.Scraper do
  import SweetXml, only: [xpath: 2, xpath: 3, sigil_x: 2]

  def scrape(url) do
    case Tesla.get(url) do
      {:ok, response} ->
        IO.puts("got response " <> url)
        parsed_entries = parse_body(response.body)
        {:ok, parsed_entries}

      {:error, error} ->
        IO.puts("error getting " <> url)
        IO.inspect(error)
        {:error, error}
    end
  end

  defp parse_body(xml) do
    parsed = SweetXml.parse(xml)
    items_count = parsed |> xpath(~x"//item"l) |> Enum.count()
    IO.puts("items_count -> ")
    IO.inspect(items_count)
    entries_count = parsed |> xpath(~x"//entry"l) |> Enum.count()
    IO.puts("entries_count -> ")
    IO.inspect(entries_count)

    if items_count > 0, do: parse_items(parsed)
    if entries_count > 0, do: parse_entries(parsed)
  end

  defp parse_items(parsed) do
    parsed
    |> xpath(~x"//item"l,
      title: ~x"./title/text()",
      content: ~x"./content/text()",
      url: ~x"./link/text()"
    )
    |> Enum.map(fn e ->
      try do
        %{
          title: e.title |> List.to_string(),
          url: e.url |> List.to_string(),
          content: (e.content || []) |> List.to_string()
        }
      rescue
        _ -> nil
      end
    end)
    |> Enum.filter(fn e -> e != nil end)
    |> IO.inspect()
  end

  defp parse_entries(parsed) do
    parsed
    |> xpath(~x"//entry"l,
      title: ~x"./title/text()",
      content: ~x"./content/text()",
      description: ~x"./description/text()",
      url: ~x"./link/@href"
    )
    |> Enum.map(fn e ->
      IO.inspect(e)

      try do
        %{
          title: e.title |> List.to_string(),
          url: e.url |> List.to_string(),
          content: (e.content or e.description) |> List.to_string()
        }
      rescue
        _ -> nil
      end
    end)
    |> Enum.filter(fn e -> e != nil end)
    |> IO.inspect()
  end
end
