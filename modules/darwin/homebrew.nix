{ ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "check";
      autoUpdate = false;
      upgrade = false;
    };

    casks = [
      "discord"
      "font-jetbrains-mono"
      "font-jetbrains-mono-nerd-font"
      "visual-studio-code"
    ];
  };
}
