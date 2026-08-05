{
  self,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ../../modules/common/nix.nix
    ../../modules/darwin
  ];

  home-manager.users.rob = import ../../home/rob;
  system.primaryUser = "rob";

  homebrew = {
    casks = [
      "discord"
      "font-jetbrains-mono"
      "font-jetbrains-mono-nerd-font"
      "ghostty"
      "slack"
      "steam"
      "visual-studio-code"
    ];
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
