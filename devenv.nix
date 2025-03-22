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
    couchdb.enable = true;
    caddy = {
      enable = true;
      config = ''
        {
        debug
        }
        https://:4895 {
        	reverse_proxy localhost:5984
        }
      '';
    };
  };

  scripts.greet.exec = ''
    echo initializing
  '';

  enterShell = ''
    greet
  '';

}
