# Installation guide for self-hosted CouchDB instance used by `obsidian-livesync` 👩‍💻

This project is a guide and sample config for running local, **dev**, self-hosted instance of a CouchDB, that can be used by [obsidian-livesync plugin](https://github.com/vrtmrz/obsidian-livesync). It's based on [devenv](https://devenv.sh/), so the assumption is that it is already installed.

### CouchDB setup 🔧

Run:

```sh
mv template.env .env
```

and edit values in `.env` as needed.

Then run:

```sh
devenv up
```

This should open devenv cli dashboard where one can observe logs for CouchDB and Caddy (reverse proxy) processes.
One can verify the setup by reaching [builtin UI](https://localhost:4895/_utils).

### Generate settings for `obsidian-livesync` plugin ⚙️

Run:

```sh
deno run -A --env-file=.env generate-settings.ts
```

It should generate a long url that contains all the configuration details. Copy it and go to obsidian.

### Import settings in `obsidian-livesync` plugin 🚀

Install `obsidian-livesync` if don't have it yet. For new installations a modal window should pop up and ask for providing config url. For existing `obsidian-livesync` installations go to:

> preferences → LiveSync → 🧙‍♂️ tab

and look for something like: _Connect with Setup URI_.

When everything is set you can verify the logs in obsidian (a box icon on the left panel) and database entries in [CouchDB UI](https://localhost:4895/_utils). Well done, congratulations 🏆
