{ config, pkgs , ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  my.cpp.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";
}