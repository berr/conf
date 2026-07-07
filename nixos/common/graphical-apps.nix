{
  lib,
  pkgs,
  config,
  ...
}:
let
  base_pkgs = with pkgs; [
      keepassxc

      wireshark

      krita
      rawtherapee

      audacity

      picard
      spotify
      strawberry

      vlc

      firefox-bin
      google-chrome

      obsidian
      super-productivity

      discord
  ];
  linux_only_pkgs =
    if pkgs.stdenv.isLinux then
      with pkgs;
      [
        gimp
        ardour
        obs-studio
      ]
    else
      [ ];

in
{
  home = {

    packages = with pkgs; [
    ];

  };

}
