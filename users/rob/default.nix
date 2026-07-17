{
  config,
  lib,
  pkgs,
  pkgs-pi,
  pkgs-unstable,
  ...
}:
{
  users.users.rob = {
    isNormalUser = true;
    description = "Robert Millar";
    extraGroups = [
      "networkmanager"
      "wheel"
    ]; # sudo
    packages = with pkgs; [
      pkgs-pi.coding-agent
    ];
  };
}
