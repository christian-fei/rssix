defmodule RssixWeb.PageControllerTest do
  use RssixWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Sources"
  end
end
