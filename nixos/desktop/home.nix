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
    homeDirectory = "/home/berr";
    stateVersion = "25.11";
  };

  systemd.user.services.mount_secrets = {
    Unit = {
      After = [ "network.target" ];
      Description = "Mount secrets from gdrive using rclone";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.rclone}/bin/rclone mount Drive:Secrets ${config.home.homeDirectory}/Documents/Drive/Secrets";
      Restart = "on-failure";
      RestartSec = "5";
    };
  };
}
