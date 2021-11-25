defmodule Rssix.Repo do
  use Ecto.Repo,
    otp_app: :rssix,
    adapter: Ecto.Adapters.Postgres
end
