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
      pkgs = import nixpkgs {
        config.allowUnfree = true;
      };
    in
    {
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        delta = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./desktop/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "berr@delta" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            config.allowUnfree = true;
            system = "x86_64-linux";
          };
          modules = [ ./desktop/home.nix ];
        };
        "berr@epsilon" = home-manager.lib.homeManagerConfiguration {
          # inherit pkgs;
          pkgs = import nixpkgs {
            config.allowUnfree = true;
            system = "aarch64-darwin";
          };
          modules = [ ./laptop/home.nix ];
        };
      };
    };
}
