{ config, lib, pkgs, ... } :
{
  services.openssh = {
    enable = lib.mkDefault true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "rob" ];
    };
    extraConfig = ''
      PrintLastLog no
    '';
  };

  users.users.rob.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKujA9W5GVAxQxS+mcYEKDw1LMonXaXVwUvJ3CLkTUGo rob@laptop"
  ];  
}