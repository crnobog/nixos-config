{
  config,
  lib,
  pkgs,
  pkgs-pi,
  pkgs-unstable,
  ...
}: {
  users.users.rob = {
    isNormalUser = true;
    description = "Robert Millar";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      tealdeer

      pkgs-pi.coding-agent
    ];
  };
}
