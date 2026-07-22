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
  boot.kernelParams = ["i915.enable_guc=3"];

  nixpkgs.config.allowUnfree = true;

  hardware.graphics.extraPackages = with pkgs; [
    intel-compute-runtime
    intel-compute-runtime.drivers
    intel-media-driver
    vpl-gpu-rt
  ];

  services.xserver.videoDrivers = ["modesetting"];

  environment.sessionVariables = {
    LIBA_DRIVER_NAME = "iHD";
  };

  system.stateVersion = "26.05";
}
