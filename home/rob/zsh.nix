{lib, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = false;
    autosuggestion.enable = true;
    # initContent = ''
    #   VI_MODE_SET_CURSOR=true
    # '';
    # oh-my-zsh = {
    #   enable = true;
    #   plugins = [
    #     "git"
    #     "gh"
    #     "jj"
    #     "vi-mode"
    #     "command-not-found"
    #     "fzf"
    #     "history"
    #     "rsync"
    #     "sudo"
    #     "rust"
    #   ];
    # };
    initContent = lib.mkAfter ''
      unsetopt extendedglob
    '';
    prezto = {
      enable = true;
      editor.keymap = "vi";
    };
  };
}
