{ ... }:
{
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  programs.git = {
    enable = true;
    settings = {
      user.name = "Robert Millar";
      user.email = "robert.millar@cantab.net";
    };
  };
  programs.jujutsu = {
    enable = true;
    settings = {
      user.name = "Robert Millar";
      user.email = "robert.millar@cantab.net";
    };
  };
  programs.oh-my-posh = { 
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    useTheme = "probua.minimal";
  };
  programs.ripgrep.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = false;
    autosuggestion.enable = true;
    localVariables = {
      VI_MODE_SET_CURSOR = true;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "gh"
        "jj"
        "vi-mode"
        "command-not-found"
        "fzf"
        "history"
        "rsync"
        "sudo"
        "rust"
      ];
    };
  };
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  home.shell.enableBashIntegration = true;
  home.shell.enableZshIntegration = true;
  home.stateVersion = "26.05";
}
