{ ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "check";
      autoUpdate = false;
      upgrade = false;
    };
  };
}
