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
