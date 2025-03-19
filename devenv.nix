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
  services.couchdb.enable = true;

  scripts.greet.exec = ''
    echo initializing
  '';

  enterShell = ''
    greet
  '';

}
