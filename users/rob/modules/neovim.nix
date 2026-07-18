{
  lib,
  inputs,
  ...
}: let
  inherit (inputs.nvf.lib.nvim.binds) mkKeymap;
in {
  programs.nvf.enable = true;
  programs.nvf.settings.vim = {
    vimAlias = true;
    lineNumberMode = "relNumber";
    searchCase = "smart";
    syntaxHighlighting = false;
    globals.mapLeader = ",";

    options = {
      shiftwidth = 4;
      tabstop = 4;
      expandtab = true;
      timeoutlen = 500;
    };

    clipboard = {
      enable = true;
      registers = "unnamedplus";
    };

    lsp = {
      enable = true;
      formatOnSave = true;
      lspkind.enable = false;
    };

    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = false;

      nix.enable = true;
      markdown.enable = true;

      bash.enable = true;
      json.enable = true;
      typescript.enable = true;
      python.enable = true;
    };

    treesitter.context.enable = true;

    comments.comment-nvim.enable = true;

    statusline = {
      lualine = {
        enable = true;
        theme = "ayu_mirage";
      };
    };

    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = false;
    };

    autopairs.nvim-autopairs.enable = true;
    autocomplete.nvim-cmp.enable = true;

    visuals = {
      blink-indent.enable = true;
      fidget-nvim.enable = true;
      highlight-undo.enable = true;
      indent-blankline.enable = false;
      nvim-cursorline.enable = true;
      nvim-web-devicons.enable = true;
    };

    ui = {
      modes-nvim.enable = false;
      noice.enable = false;
      borders.enable = true;
      smartcolumn = {
        enable = true;
      };
    };

    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    };

    keymaps = [
      (mkKeymap "t" "<Esc><Esc>" "<C-\\><C-n>" {desc = "Quick exit terminal mode";})
    ];

    terminal.toggleterm.enable = true;

    mini = {
      operators.enable = true;
      pick.enable = true;
      surround.enable = true;
    };

    autocmds = [
      {
        event = ["FileType"];
        pattern = ["nix"];
        callback = lib.generators.mkLuaInline ''
          function()
            vim.bo.shiftwidth = 2;
            vim.bo.tabstop = 2;
          end
        '';
      }
    ];

    luaConfigRC.osc52-clipboard = ''
      local function local_paste()
        return { vim.fn.split(vim.fn.getreg('''), '\n'), vim.fn.getregtype(''') }
      end
      vim.g.clipboard = {
        name = "OSC 52",
        copy = {
          ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
          ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
        },
        paste = {
          ['*'] = local_paste,
          ['+'] = local_paste,
        },
      }
    '';
  };
}
