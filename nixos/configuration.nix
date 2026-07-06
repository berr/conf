{ config, pkgs, outputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "berr";

  networking.hostName = "baphomet";
  networking.networkmanager.enable = true;

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

  # TODO: Compare X11 vs Wayland and disable one
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };


  # Printing
  services.printing.enable = true;

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.berr = {
    isNormalUser = true;
    description = "Felipe Silveira";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
    packages = with pkgs; [ ];
  };

  # Virtualization
  programs.virt-manager.enable = true;
  virtualisation.docker = {
    enable = true;
  };
  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };

  # RGB :)
  services.hardware.openrgb.enable = true;

  # Allow unfree packages
  nixpkgs = {
    overlays = [
        outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
    config.permittedInsecurePackages = [
        "docker-28.5.2"
        "electron-39.8.10"
    ];

  };

  programs.steam = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
      dnsmasq # required for libvirt networking
      openrgb
      lm_sensors
      kdePackages.krohnkite
      qjackctl
      pwvucontrol

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

  services.openssh.enable = true;
  networking.firewall.enable = false;

  system.stateVersion = "25.11";
}
