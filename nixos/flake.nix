{
  description = "Nix configuration for my systems: a linux desktop and a arm macbook";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs_unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs_unstable,
      home-manager,
      ...
    }:
    let
      inherit (self) outputs;
    in
    {
      nixosConfigurations = {
        delta = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs nixpkgs nixpkgs_unstable; };
          modules = [
            ./desktop/configuration.nix
            {
              nixpkgs.overlays = [
                (final: prev: { kdePackages = nixpkgs_unstable.legacyPackages.x86_64-linux.kdePackages; })
              ];
              nixpkgs.config.allowUnfree = true;
            }
          ];

        };
      };

      homeConfigurations = {
        "berr@delta" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            config.allowUnfree = true;
            system = "x86_64-linux";
            overlays = [
                (final: prev: { kdePackages = nixpkgs_unstable.legacyPackages.x86_64-linux.kdePackages; })
                        ];
          };
          modules = [ ./pkgs/kvitals.nix ./desktop/home.nix ];
        };
        "berr@epsilon" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            config.allowUnfree = true;
            system = "aarch64-darwin";
          };
          modules = [ ./laptop/home.nix ];
        };
      };
    };
}
