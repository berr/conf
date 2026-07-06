{
  lib,
  pkgs,
  config,
  ...
}:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = "source ${config.home.homeDirectory}/config/bash/bashrc_tail.sh";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "rust"
        "python"
        "pyenv"
        "uv"
      ];
      theme = "philips";
    };
  };

  programs.neovim = {
    enable = true;
    sideloadInitLua = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;
  };

  programs.steam = true;

  fonts.fontconfig.enable = true;

  home = {

    packages = with pkgs; [
      # Needed for config management
      git
      just
      rclone
      nixfmt

      # Terminal tools
      tmux
      htop
      iotop
      sysstat
      lm_sensors
      ethtool
      pciutils
      usbutils
      unrar
      p7zip
      lsof
      curl
      wget
      ripgrep
      # Network management
      nmap
      tcpdump
      traceroute
      bind
      wireshark

      # Development
      gnumake
      pkg-config
      rustup
      python315
      uv
      gcc
      nodejs
      lazygit
      # Virt
      lxc
      virt-manager
      # Language servers
      pyright
      lua-language-server

      nerd-fonts.jetbrains-mono
      wl-clipboard

      keepassxc

      gimp
      krita
      rawtherapee

      ardour

      picard
      audacity
      spotify
      strawberry

      vlc

      obs-studio

      firefox-bin
      google-chrome

      obsidian
      super-productivity

      discord
      slack

      alacritty
      jetbrains.rust-rover
    ];

    username = "berr";
    homeDirectory = "/home/berr";

    stateVersion = "25.11";

    file.git = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/config/git/gitconfig";
      target = "./.gitconfig";
    };

    file.neovim = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/config/nvim";
      target = "./.config/nvim";
    };

    file.tmux = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/config/tmux";
      target = "./.config/tmux";
    };

    file.alacritty = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/config/alacritty";
      target = "./.config/alacritty";
    };

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
