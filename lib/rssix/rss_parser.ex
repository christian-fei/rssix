defmodule Rssix.RssParser do
  import SweetXml, only: [xpath: 2, xpath: 3, sigil_x: 2]

  def parse_body(xml) do
    parsed = SweetXml.parse(xml)
    items_count = parsed |> xpath(~x"//item"l) |> Enum.count()
    # IO.puts("items_count -> ")
    # IO.inspect(items_count)
    # entries_count = parsed |> xpath(~x"//entry"l) |> Enum.count()
    # IO.puts("entries_count -> ")
    # IO.inspect(entries_count)

    if items_count > 0, do: parse_items(parsed), else: parse_entries(parsed)
  end

  defp parse_items(parsed) do
    parsed
    |> xpath(~x"//item"l,
      title: ~x"./title/text()",
      content: ~x"./content/text()",
      description: ~x"./description/text()",
      url: ~x"./link/text()"
    )
    |> Enum.map(fn e ->
      try do
        %{
          title: e.title |> List.to_string(),
          url: e.url |> List.to_string(),
          content: (e.content || e.description) |> List.to_string()
        }
      rescue
        error ->
          IO.puts("error happened")
          IO.inspect(error)
          nil
      end
    end)
    |> Enum.filter(fn e -> e != nil end)
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
      try do
        %{
          title: e.title |> List.to_string(),
          url: e.url |> List.to_string(),
          content: (e.content || e.description) |> List.to_string()
        }
      rescue
        error ->
          IO.puts("error happened")
          IO.inspect(error)
          nil
      end
    end)
    |> Enum.filter(fn e -> e != nil end)
  end
end
