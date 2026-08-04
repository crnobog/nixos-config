{...}: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "check";

    casks = [
      "discord"
      "font-jetbrains-mono"
      "font-jetbrains-mono-nerd-font"
      "visual-studio-code"
    ];
  };
}
