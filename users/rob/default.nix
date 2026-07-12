{ config, lib, pkgs, ... } :
{
  users.users.rob = {
    isNormalUser = true;
    description = "Robert Millar";
    extraGroups = [ "networkmanager" "wheel" ]; # sudo
    packages = with pkgs; [];
  };
}