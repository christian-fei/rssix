# Rssix

> Personal RSS reader, but BEAM-flavoured

# setup

```sh
mix deps.get
```

start postgres:

```sh
docker run -v $PWD/data:/var/lib/postgresql/data --rm --name postgres-db -p 5432:5432 -e POSTGRES_PASSWORD=postgres -d postgres

# or

./start-pg # runs above command
```

the setup ecto:

```sh
mix ecto.setup
```

and run phoenix:

```sh
iex -S mix phx.server
```

visit [`localhost:4000`](http://localhost:4000)

# other info

to stop postgres, run

```sh
docker stop postgres-db
```

# Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
