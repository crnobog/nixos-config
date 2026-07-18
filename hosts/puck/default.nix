{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  my.cpp.enable = true;
  my.llmInference.sycl = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nixpkgs.config.allowUnfree = true;

  hardware.graphics.extraPackages = with pkgs; [
    intel-compute-runtime
    intel-compute-runtime.drivers
  ];

  system.stateVersion = "26.05";
}
