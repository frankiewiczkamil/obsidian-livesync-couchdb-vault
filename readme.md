# Self-hosted `obsidian-livesync` guide

This project is a guide and sample config for running local, _dev_, self-hosted instance of couchdb, that can be used by [obsidian-livesync plugin](https://github.com/vrtmrz/obsidian-livesync). It uses [devenv](https://devenv.sh/), so the assumption is that you already have it installed.

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

This should open devenv cli console where you can observe logs for CouchDB and Caddy (reverse proxy) processes.
If you are running it locally, then you verify that [builtin UI](https://localhost:4895/_utils) is working and you can login.

### Init CouchDB

Open another terminal and run:

```sh
./couchdb-init.sh
```

and verify that it ends with _CouchDB initialized successfully_ message.

### Generate CouchDB settings for `obsidian-livesync` plugin

Run

```sh
deno run -A --env-file=.env generate-settings.ts
```

It should generate a long url for you. Copy it and go to obsidian. Install `obsidian-livesync` if don't have it yet, and use it in plugin. For new installation wizard should guide you and ask for it. For existing installation go to preferences, find the plugin settings, go to wizard 🧙‍♂️ tab and look for something like: _Connect with Setup URI_.
