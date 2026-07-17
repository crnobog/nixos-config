{
  programs.nvf = {
    enable = true;
    settings.vim = {
      vimAlias = true;
      lsp = {
        enable = true;
      };

      statusline = {
        lualine = {
          enable = true;
          theme = "catppuccin";
        };
      };

      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
        transparent = false;
      };
    };
  };
}
