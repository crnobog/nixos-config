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
      "video"
      "render"
    ];
    packages = with pkgs; [
      delta
      tealdeer

      pkgs-pi.coding-agent
    ];
  };
}
