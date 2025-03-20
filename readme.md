# Self-hosted `obsidian-livesync` guide

This project is a simplified guide and sample config for running local, self-hosted instance of couchdb, that can be used by [obsidian-livesync plugin](https://github.com/vrtmrz/obsidian-livesync). It uses [devenv](https://devenv.sh/), so the assumption is that you already have it installed.

### `Devenv` setup

Run

```sh
mv template.env .env
```

and edit values in `.env`.

Then run

```sh
devenv up
```

and verify that [builtin UI](http://localhost:5984/_utils) works.

### Init CouchDB

Run

```sh
./couchdb-init.sh
```

and verify that it ends with _CouchDB initialized successfully_ message.

### Setup CouchDB

Run

```sh
mv template.env.setup-db .env.setup-db
```

and edit values in `.env.setup-db`.

Then run

```sh
deno run -A --env-file=.env.setup-db setup-db.ts
```

> [!TIP] If you don't have deno installed, you can
>
> - add it to devenv: `languages.deno.enable`, or
> - use nix shell: `nix-shell -p deno`, or
> - install it using your favorite package manager

It should generate a long url for you. Copy it and go to obsidian. Install `obsidian-livesync` if don't have it yet, and use it in plugin. For new installation wizard should guide you and ask for it. For existing installation go to preferences, find the plugin settings, go to wizard 🧙‍♂️ tab and look for something like: _Connect with Setup URI_.
