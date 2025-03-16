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

  scripts.greet.exec = ''
    echo initializing
  '';

  enterShell = ''
    greet
  '';

}
