{
  config,
  lib,
  pkgs,
  hostName,
  inventory,
  ...
}:
{
  config =
    if (hostName == "meshify") then
      {
        services.nfs.server.enable = true;
        services.nfs.server.exports = ''
          /export 192.168.0.0/24(ro,fsid=0,no_subtree_check)
          /export/bulk 192.168.0.0/24(rw,insecure,no_subtree_check)
          /export/fast 192.168.0.0/24(rw,insecure,no_subtree_check)
        '';
        networking.firewall.allowedTCPPorts = [ 2049 ];
      }
    else
      {
        boot.supportedFilesystems = [ "nfs" ];
        fileSystems."/nfs/meshify/bulk" = {
          device = "${inventory.meshify.ip}:/bulk";
          fsType = "nfs4";
          options = [
            "noauto"
            "x-systemd.automount"
            "x-systemd.idle-timeout=600"
            "_netdev"
          ];
        };
        fileSystems."/nfs/meshify/fast" = {
          device = "${inventory.meshify.ip}:/fast";
          fsType = "nfs4";
          options = [
            "noauto"
            "x-systemd.automount"
            "x-systemd.idle-timeout=600"
            "_netdev"
          ];
        };
      };
}
