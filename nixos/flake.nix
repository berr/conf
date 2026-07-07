{
  description = "Nix configuration for my systems: a linux desktop and a arm macbook";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        baphomet = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./desktop/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "berr@delta" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./desktop/home.nix ];
        };
      };
    };
}
