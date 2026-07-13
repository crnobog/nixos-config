{ config, lib, pkgs, hostName, hosts, ... } : 
{
  config = if (hostName == "meshify") then {
    services.nfs.server.enable = true;
    services.nfs.server.exports = ''
      /export 192.168.0.0/24(ro,fsid=0,no_subtree_check)
      /export/bulk 192.168.0.0/24(rw,insecure,no_subtree_check)
      /export/fast 192.168.0.0/24(rw,insecure,no_subtree_check)
    '';
    networking.firewall.allowedTCPPorts = [ 2049 ];
  } else {
    boot.supportedFilesystems = [ "nfs" ];
    fileSystems."/nfs/meshify/bulk" = { 
      device = "${hosts.meshify.ip}:/bulk";
      fsType = "nfs4";
    };
    fileSystems."/nfs/meshify/fast" = { 
      device = "${hosts.meshify.ip}:/fast";
      fsType = "nfs4";
    };
  };
}