{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ../common/common_home.nix
  ];


  home = {

    username = "berr";
    homeDirectory = "/home/berr";
    stateVersion = "25.11";

    packages = with pkgs; [
      # linux specific
      ethtool
      iotop
      lm_sensors
      pciutils
      sysstat
      traceroute
      usbutils
      # Virt
      lxc
      virt-manager
      wl-clipboard
    ];
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
