{
  lib,
  pkgs,
  config,
  platform,
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
    defaultKeymap = "emacs";

    history.size = 10000;
    oh-my-zsh = {
      enable = true;
    };

    initContent = "source ${config.home.homeDirectory}/config/zsh/zshrc";

  };

  home.packages = with pkgs; [
    home-manager

    starship

    # Needed for config management
    git
    just
    nixfmt
    rclone

    # Terminal tools
    alacritty
    curl
    htop
    lsof
    p7zip
    ripgrep
    tmux
    tmuxp
    unrar
    wget
    # Network management
    bind
    nmap
    tcpdump
  ];
}
