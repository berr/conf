{
  lib,
  pkgs,
  config,
  ...
}:
{
  programs.neovim = {
    enable = true;
    sideloadInitLua = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;
  };

  home = {

    packages = with pkgs; [
      git
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
    ];
    };

}
