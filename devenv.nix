{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  packages = [ ];
  dotenv.enable = true;

  services = {
    couchdb = {
      enable = true;
      settings = {
        cors = {
          credentials = true;
          origins = "app://obsidian.md,capacitor://localhost,http://localhost";
        };
        chttpd = {
          bind_address = "127.0.0.1";
          enable_cors = true;
          max_http_request_size = 4294967296;
          port = 5984;
          require_valid_user = true;
        };
        chttpd_auth = {
          require_valid_user = true;
        };
        couchdb = {
          max_document_size = 50000000;
          single_node = true;

        };
        httpd = {
          WWW-Authenticate = "Basic realm=couchdb";
          bind_address = "127.0.0.1";
          enable_cors = true;
          port = 5986;
        };
        admins = {
          "${config.env.username}" = "${config.env.password}";
        };
      };
    };
    caddy = {
      enable = true;
      config = ''
        {
          debug
        }
        https://${config.env.hostname}:4895 {
        	reverse_proxy localhost:5984
        }
      '';
    };
  };
  languages.deno.enable = true;

  scripts.greet.exec = ''
    echo initializing
  '';

  enterShell = ''
    greet
    export HOSTNAME="$(hostname)"
  '';

}
