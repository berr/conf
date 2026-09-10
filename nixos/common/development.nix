{
  lib,
  pkgs,
  config,
  ...
}:
let
  base_pkgs = with pkgs; [
    git
    gcc
    gnumake
    lazygit
    pkg-config

    devenv

    helix
    tree-sitter

    cargo
    rustc
    rust-analyzer
    rustfmt
    clippy

    python315
    uv
    ruff
    ty

    nodejs

    # Language servers
    lua-language-server
    pyright
    tailwindcss-language-server

    # ai helpers
    claude-code
  ];
  linux_only_pkgs =
    if pkgs.stdenv.isLinux then
      with pkgs;
      [
        lxc
        virt-manager
      ]
    else
      [ ];

in
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
  home.packages = base_pkgs ++ linux_only_pkgs;

}
