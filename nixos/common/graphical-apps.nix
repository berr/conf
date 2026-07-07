{
  lib,
  pkgs,
  config,
  ...
}:
let
  base_pkgs = with pkgs; [
      wireshark


      audacity

      keepassxc

      picard


      firefox-bin
      google-chrome

      # obsidian
      # super-productivity

      discord
  ];
  linux_only_pkgs =
    if pkgs.stdenv.isLinux then
      with pkgs;
      [
        gimp
        ardour
        obs-studio
        krita
      rawtherapee
      strawberry
      vlc
      ]
    else
      [ ];

in
{
  home = {

    packages = base_pkgs ++ linux_only_pkgs;


  };

}
