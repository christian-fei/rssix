defmodule RssixWeb.Router do
  use RssixWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {RssixWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RssixWeb do
    pipe_through :browser

    live "/", IndexLive

    # get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", RssixWeb do
  #   pipe_through :api
  # end
end
