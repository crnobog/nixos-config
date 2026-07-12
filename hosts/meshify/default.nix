{ config, pkgs , ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  my.cpp.enable = true;
  my.llmInference.cuda = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nixpkgs.config.allowUnfree = true;

  fileSystems."/mnt/fast" = {
    fsType = "ext4";
    device = "/dev/disk/by-uuid/60fa58cf-b381-4bc4-9b82-37cac0d81fac";
  };
  fileSystems."/mnt/bulk" = {
    fsType = "ext4";
    device = "/dev/disk/by-uuid/30e36706-dd34-4369-84df-a42854b1993d";
  };

  system.stateVersion = "26.05";
}