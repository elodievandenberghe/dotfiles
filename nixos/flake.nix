{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, ... }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };

    lib = nixpkgs.lib;
  in {
    elodie-laptop = lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs pkgs-stable;
      };
      modules = [ ./hosts/laptop/configuration.nix ];
    };

    hypotheticaldesktop = lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs pkgs-stable;
      };
      modules = [ ./hosts/hypotheticaldesktop/configuration.nix ];
    };
  };
}

