defmodule Rssix.RssParserTest do
  use ExUnit.Case, async: true

  test "parses feed with entries" do
    assert [
             %{
               content: "Some content",
               title: "Some title",
               url:
                 "https://example.com/posts/123/?utm_medium=rss&utm_source=rss&utm_campaign=rss"
             }
           ] == Rssix.RssParser.parse_body(with_entries())
  end

  test "parses feed with items" do
    assert [
             %{
               content: "Some description",
               title: "Some ttle",
               url: "https://example.com/post/"
             }
           ] ==
             Rssix.RssParser.parse_body(with_items())
  end

  defp with_entries,
    do: """
    <?xml version="1.0" encoding="utf-8"?>
    <feed xmlns="http://www.w3.org/2005/Atom">
      <title>Some title</title>
      <subtitle>Some subtitle</subtitle>
      <link href="https://example.com/rss.xml" rel="self"/>
      <updated>2021-10-30T00:00:00Z</updated>
      <id>https://example.com</id>
      <author>
        <name>example author</name>
      </author>
      <entry>
        <title>Some title</title>
        <link href="https://example.com/posts/123/?utm_medium=rss&amp;utm_source=rss&amp;utm_campaign=rss"/>
        <updated>2021-01-05T00:00:00Z</updated>
        <id>https://cri.dev/posts/123/</id>
        <content type="html">Some content</content>
      </entry>
    </feed>
    """

  defp with_items,
    do: """
    <?xml version="1.0" encoding="UTF-8"?>
    <rss version="2.0">
      <channel>
        <title>example title</title>
        <description>example description</description>
        <link>https://example.com/</link>
          <item>
            <title>Some ttle</title>
            <description>Some description</description>
            <pubDate>27 Nov 2021 12:39:42 +0000</pubDate>
            <link>https://example.com/post/</link>
            <guid>https://example.com/post/</guid>
          </item>
      </channel>
    </rss>
    """
end
