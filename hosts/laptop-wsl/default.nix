{ config, pkgs, ... }:
{
  imports = [
    ../common.nix
  ];
  
  wsl.enable = true;
  wsl.defaultUser = "rob";

  services.openssh.enable = false;

  system.stateVersion = "26.05";
}