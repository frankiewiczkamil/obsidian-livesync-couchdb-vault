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
  services.couchdb = {
    enable = true;
    settings = {
      admins = {
        kamil = config.env.pwd;
      };
    };
  };

  scripts.greet.exec = ''
    echo initializing
  '';

  enterShell = ''
    greet
  '';

}
