{
  lib,
  pkgs,
  config,
  ...
}:
{
  home = {

    packages = with pkgs; [
      keepassxc

      wireshark

      gimp
      krita
      rawtherapee

      ardour
      audacity

      picard
      spotify
      strawberry

      obs-studio
      vlc


      firefox-bin
      google-chrome

      obsidian
      super-productivity

      discord
    ];

  };

}
