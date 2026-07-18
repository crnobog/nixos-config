{...}: {
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
    prezto = {
      enable = true;
      editor.keymap = "vi";
      extraConfig = ''
        if [[ -n "$NVIM$" || -n "$VIM_TERMINAL" || -n "$VIMRUNTIME" ]]; then
          bindkey -e
        fi
      '';
    };
  };
}
