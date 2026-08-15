{
  pkgs,
  lib,
  inventory,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    openssh
  ];
  programs.ssh = {
    knownHosts = lib.mapAttrs (hostName: host: {
      hostNames = [ host.ip ];
      publicKey = host.publicKey;
    }) (lib.filterAttrs (hostName: host: host ? publicKey) inventory);
  };
}
