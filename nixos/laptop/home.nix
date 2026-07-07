{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ../common/configs.nix
    ../common/terminal-tools.nix
    ../common/development.nix
    ../common/fonts.nix
    ../common/graphical-apps.nix
  ];

  home = {

    username = "berr";
    homeDirectory = "/Users/berr";
    stateVersion = "25.11";

    packages = with pkgs; [ ];
  };
}
