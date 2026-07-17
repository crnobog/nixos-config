{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

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
      nixos-wsl,
      home-manager,
      pi,
      nvf,
    }@inputs:
    let
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
        laptop-wsl = {
          hostName = "laptop-wsl";
          ip = "192.168.0.211";
          wsl = true;
          extraModules = [ nixos-wsl.nixosModules.default ];
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

      mkHost =
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
              hosts
              ;
            pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
            pkgs-pi = pi.packages.${system};
          };
          modules = [
            ./hosts/${hostName}
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = ".bak";
              home-manager.overwriteBackup = true;
              home-manager.users.rob = import ./users/rob/home.nix;
              home-manager.sharedModules = [ 
                nvf.homeManagerModules.default
              ];
            }
          ]
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        puck = mkHost hosts.puck;
        meshify = mkHost hosts.meshify;
        laptop-wsl = mkHost hosts.laptop-wsl;
      };
    };
}
