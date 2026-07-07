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

  fonts.fontconfig.enable = true;

  home = {

    packages = with pkgs; [
      home-manager

      # Needed for config management
      git
      just
      nixfmt
      rclone

      nerd-fonts.jetbrains-mono

      # Terminal tools
      alacritty
      curl
      htop
      lsof
      p7zip
      ripgrep
      tmux
      unrar
      wget
      # Network management
      bind
      nmap
      tcpdump
      wireshark

      # Development
      gcc
      gnumake
      lazygit
      nodejs
      pkg-config
      python315
      rustup
      uv
      # Language servers
      lua-language-server
      pyright


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
      jetbrains.rust-rover
    ];


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

}
