{ config, pkgs, ... }:
{
  imports = [
    ../../modules/common/nix.nix
    ../../modules/nixos
  ];
  
  wsl.enable = true;
  wsl.defaultUser = "rob";

  services.openssh.enable = false;

  system.stateVersion = "26.05";
}