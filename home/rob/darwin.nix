{ pkgs, lib, ... }:
lib.mkIf pkgs.stdenv.isDarwin {
  programs.ghostty = {
    enable = true;
    package = null; # Installed with homebrew
    enableZshIntegration = true;
    settings = {
      theme = "Catppuccin Macchiato";
      font-family = "JetBrainsMono Nerd Font";
      font-size = 14;
    };
  };
}
