{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-wsl }@inputs :
  let 
    lib = nixpkgs.lib;

    mkHost = { hostname, system ? "x86_64-linux", extraModules ? [], wsl ? false }:
      lib.nixosSystem {
        inherit system;
        specialArgs = { 
            inherit inputs hostname wsl;
        };
        modules = [
          ./hosts/${hostname}
        ] ++ extraModules;
      };
  in {
    nixosConfigurations = { 
      laptop-wsl = mkHost { 
        hostname = "laptop-wsl"; 
        extraModules = [ nixos-wsl.nixosModules.default ];
      };
      meshify = mkHost { hostname = "meshify"; };
    };
  };
}