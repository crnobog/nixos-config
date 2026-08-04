{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    pi.url = "github:lukasl-dev/pi.nix";
    pi.inputs.nixpkgs.follows = "nixpkgs";

    nvf.url = "github:NotAShelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nix-darwin,
      nixos-wsl,
      home-manager,
      pi,
      nvf,
    }@inputs:
    let
      lib = nixpkgs.lib;

      inventory = import ./modules/common/inventory.nix;

      mkNixosHost =
        {
          hostName,
          system ? "x86_64-linux",
          extraModules ? [ ],
          wsl ? false,
          ...
        }:
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              hostName
              wsl
              inventory
              inputs
              ;
          };
          modules = [
            ./modules/common/nix.nix
            ./modules/nixos
            ./hosts/${hostName}
            home-manager.nixosModules.home-manager
            ./modules/common/home-manager.nix
            # TODO: Where to configure this?
            {
              home-manager.users.rob = import ./home/rob;
            }
          ]
          ++ lib.optionals wsl [
            nixos-wsl.nixosModules.wsl
          ];
        };
      mkDarwinHost =
        {
          hostName,
          system ? "aarch64-darwin",
          ...
        }:
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = {
            inherit
              self
              hostName
              inventory
              inputs
              ;
          };
          modules = [
            ./modules/common/nix.nix
            ./modules/darwin
            ./hosts/${hostName}
            home-manager.darwinModules.home-manager
            ./modules/common/home-manager.nix
          ];
        };
    in
    {
      nixosConfigurations = {
        puck = mkNixosHost inventory.puck;
        meshify = mkNixosHost inventory.meshify;
        laptop-wsl = mkNixosHost inventory.laptop-wsl;
      };
      darwinConfigurations = {
        sylph = mkDarwinHost inventory.sylph;
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-tree;
    };
}
