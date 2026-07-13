{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/3cc28e46-371c-4975-a61a-8baf0d39e6f7";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7876-0021";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/mnt/fast" =
    { device = "/dev/disk/by-uuid/60fa58cf-b381-4bc4-9b82-37cac0d81fac";
      fsType = "ext4";
    };

  fileSystems."/mnt/bulk" =
    { device = "/dev/disk/by-uuid/30e36706-dd34-4369-84df-a42854b1993d";
      fsType = "ext4";
    };

  fileSystems."/export/bulk" =
    { device = "/mnt/bulk";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/export/fast" =
    { device = "/mnt/fast";
      fsType = "none";
      options = [ "bind" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/b1bb240b-c181-4030-8655-832eaf312310"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
