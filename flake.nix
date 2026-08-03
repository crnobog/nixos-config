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

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nix-darwin,
    nixos-wsl,
    home-manager,
    pi,
    nvf,
  } @ inputs: let
    lib = nixpkgs.lib;

    hosts = {
      puck = {
        hostName = "puck";
        ip = "192.168.0.156";
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAikxJyr2aBfVWqnrxu/Ual1hrMRg/dq0OYSmora8xaB";
      };
      meshify = {
        hostName = "meshify";
        ip = "192.168.0.126";
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAJEMzg5GZ9mz1x8ujXPXgD03Y37eBT4I7HFE78HB418";
      };
      sylph = { 
        hostName = "sylph";
        ip = "192.168.0.148";
      };
      laptop-wsl = {
        hostName = "laptop-wsl";
        ip = "192.168.0.211";
        wsl = true;
        extraModules = [nixos-wsl.nixosModules.default];
      };
      terra = {
        hostName = "terra";
        ip = "192.168.0.147";
      };
      laptop = {
        hostName = "laptop";
        ip = "192.168.0.211";
      };
    };

    mkNixosHost = {
      hostName,
      system ? "x86_64-linux",
      extraModules ? [],
      wsl ? false,
      ...
    }:
      lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit
            hostName
            wsl
            hosts
            inputs
            ;
          pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
          pkgs-pi = pi.packages.${system};
        };
        modules =
          [
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
          ++ extraModules;
      };
    mkDarwinHost = {
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
            hosts
            inputs
            ;
          pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
          # pkgs-pi = pi.packages.${system};
        };
        modules =
          [
            ./modules/common/nix.nix
            ./modules/darwin
            ./hosts/${hostName}
            home-manager.darwinModules.home-manager
            ./modules/common/home-manager.nix
            # TODO: Where to configure this?
            {
              home-manager.users.rob = import ./home/rob;
            }
          ];
      };
  in {
    nixosConfigurations = {
      puck = mkNixosHost hosts.puck;
      meshify = mkNixosHost hosts.meshify;
      laptop-wsl = mkNixosHost hosts.laptop-wsl;
    };
    darwinConfigurations = { 
      sylph = mkDarwinHost hosts.sylph;
    };
  };
}
