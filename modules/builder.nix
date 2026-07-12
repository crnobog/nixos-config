{
  config,
  lib,
  pkgs,
  hostname,
  ...
}:
let
  buildMachines = builtins.filter (b: b.hostName != "${hostname}-builder") [
    {
      hostName = "puck";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      sshUser = "builder";
      sshKey = "/root/.ssh/id_builder";
      maxJobs = 3;
      speedFactor = 4;
      supportedFeatures = [
        "nixos-test"
        "benchmark"
        "big-parallel"
        "kvm"
      ];
      mandatoryFeatures = [ ];
    }

    {
      hostName = "meshify";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      sshUser = "builder";
      sshKey = "/root/.ssh/id_builder";
      maxJobs = 2;
      speedFactor = 1;
      supportedFeatures = [
        "nixos-test"
        "benchmark"
        "big-parallel"
        "kvm"
      ];
      mandatoryFeatures = [ ];
    }
  ];
in
{
  users.users.builder = {
    isSystemUser = true;
    description = "Nix remote builder user";
    shell = pkgs.bashInteractive;
    hashedPassword = "!";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJQhxpuxN6uDZK4AZP4kmEl503kBC7/eTScFgYeUG3hM builder@all"
    ];
  };

  nix = {
    inherit buildMachines;
    distributedBuilds = true;
    settings.builders-use-substitutes = true;
    settings.trusted-users = [ "builder" ];
  };
}
