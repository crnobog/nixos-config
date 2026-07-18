{...}: {
  imports = [
    ./modules/neovim.nix
    ./modules/zsh.nix
  ];
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  programs.gh.enable = true;
  programs.git = {
    enable = true;
    settings = {
      user.name = "Robert Millar";
      user.email = "robert.millar@cantab.net";
      core = {
        pager = "delta";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      delta = {
        "line-numbers" = true;
        "side-by-side" = true;
        navigate = true;
        dark = true;
      };
      merge = {
        conflictStyle = "zdiff3";
      };
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
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  home.shell.enableBashIntegration = true;
  home.shell.enableZshIntegration = true;
  home.stateVersion = "26.05";
}
