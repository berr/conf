{
  config,
  pkgs,
  outputs,
  ...
}:

{
  system.stateVersion = "25.11";

  imports = [
    ./hardware.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services = {
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "berr";
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    # TODO: Compare X11 vs Wayland and disable one
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    openssh.enable = true;
    printing.enable = true;
    pulseaudio.enable = false;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  networking = {
    hostName = "baphomet";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  time.timeZone = "America/Sao_Paulo";

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  users.users.berr = {
    isNormalUser = true;
    description = "Felipe Silveira";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "docker"
    ];
    packages = with pkgs; [ ];
  };

  security.rtkit.enable = true;
  # Virtualization
  programs.virt-manager.enable = true;
  virtualisation.docker = {
    enable = true;
  };
  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    config.permittedInsecurePackages = [
      "docker-28.5.2"
      "electron-39.8.10"
    ];

  };

  environment.systemPackages = with pkgs; [
    dnsmasq # required for libvirt networking
    openrgb
    lm_sensors
    kdePackages.krohnkite
    qjackctl
    pwvucontrol
    home-manager

    # yabridge
    # yabridgectl
    # unstable.wineWow64Packages.staging
    # unstable.winetricks
    # neural-amp-modeler-lv2
    # lsp-plugins
    # guitarix
  ];

  # Configure smart:
  # https://search.nixos.org/options?channel=25.11&show=services.smartd.enable&query=services.smartd.

}
