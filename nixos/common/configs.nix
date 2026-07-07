
{
  lib,
  pkgs,
  config,
  platform,
  ...
}:
{
    home.file.git = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/config/git/gitconfig";
      target = "./.gitconfig";
    };

    home.file.neovim = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/config/nvim";
      target = "./.config/nvim";
    };

    home.file.tmux = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/config/tmux";
      target = "./.config/tmux";
    };

    home.file.alacritty = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/config/alacritty";
      target = "./.config/alacritty";
    };
}
