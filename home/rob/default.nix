{ config, lib, pkgs, ... } :
{
  users.users.rob = {
    isNormalUser = true;
    description = "Robert Millar";
    extraGroups = [ "networkmanager" "wheel" ]; # sudo
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKujA9W5GVAxQxS+mcYEKDw1LMonXaXVwUvJ3CLkTUGo rob@laptop"
    ];
    packages = with pkgs; [];
  };
}