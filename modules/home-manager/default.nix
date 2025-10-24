# https://nix-community.github.io/home-manager/options.html
{ pkgs, ... }:
let
  pkl-neovim = pkgs.vimUtils.buildVimPlugin {
    name = "pkl-neovim";
    src = pkgs.fetchFromGitHub {
      owner = "apple";
      repo = "pkl-neovim";
      rev = "ca2ed06979003c1cefc7c5e804d558cd53186ca2";
      sha256 = "03wjqhi0s3b3v2k476wkz7ajm8s530jrbzs0c6c3yfy1w9wh9k1x";
    };
  };
in
{
  home = {
    stateVersion = "22.11";
    packages = with pkgs; [
      awscli2
      ko
      go
      gzip
      httpie
      colima
      curl
      docker
      docker-compose
      duf
      (google-cloud-sdk.withExtraComponents # gcloud components list
        (
          with google-cloud-sdk.components;
          [
            gke-gcloud-auth-plugin
            gcloud-man-pages
          ]
        )
      )
      kubectl
      kubecolor
      kubectx
      fd
      pre-commit
      yajsv
      nixfmt
      parallel
      jq
      less
      m4
      nixpkgs-fmt
      ripgrep
      shellcheck
      tig
      watch
    ];
    sessionVariables = {
      HISTFILE = "$HOME/bash_history/$(date +%Y-%m)";
      PAGER = "less";
      AWS_PAGER = "";
      LESS = "-R"; # tell less to allow raw control characters by default
      CLICLOLOR = 1;
      PATH = "$PATH:$HOME/go/bin";
      _ZO_DOCTOR = "0";
    };
    sessionPath = [ "$HOME/bin" ];
  };

  # https://nix-community.github.io/home-manager/options.html
  programs = {
    zoxide = {
      enable = true;
      options = [ "--cmd j" ];
      enableBashIntegration = true;
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      defaultEditor = true;

      extraConfig = ''
        lua require('gitsigns').setup()

        " Pkl LSP configuration
        lua << EOF
        vim.g.pkl_neovim = {
          start_command = { '/opt/homebrew/bin/pkl-lsp' }
        }

        -- Format on save for all files with LSP formatting support
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*",
          callback = function()
            vim.lsp.buf.format({ async = false })
          end,
        })
        EOF

        " Treesitter configuration
        lua << EOF
        require('nvim-treesitter.configs').setup {
          ensure_installed = {},  -- Let Nix handle installation
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
          indent = {
            enable = true
          },
        }
        EOF

        set list listchars=nbsp:¬,tab:»·,trail:·,extends:>
        set shiftwidth=4
        set softtabstop=4
        set tabstop=4
        set wildmode=longest,list,full
        set wildmenu
        autocmd ColorScheme * highlight Whitespace ctermfg=red guifg=#FF0000
        autocmd BufWritePre * :%s/\s\+$//e
        colorscheme dracula
        set undofile
        set ignorecase
        unmap Y

        " Jump to last cursor position when opening files
        " See |last-position-jump|.
        :au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
      '';

      plugins = with pkgs.vimPlugins; [
        vim-commentary
        vim-fugitive
        vim-nix
        vim-go
        vim-rhubarb
        dracula-vim
        gitsigns-nvim
        pkl-neovim
        (nvim-treesitter.withPlugins (p: [
          p.bash
          p.go
          p.json
          p.lua
          p.nix
          p.pkl
          p.python
          p.yaml
        ]))
      ];

    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
    };
  };

  programs.eza.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        name = "Kai Hendry";
        email = "hendry@iki.fi";
      };
      alias = {
        prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
        root = "rev-parse --show-toplevel";
      };
      color.ui = true;
      github.user = "kaihendry";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };

  programs.bash.enable = true;
  programs.bash.enableCompletion = true;

  programs.direnv.enable = true;
  programs.direnv.enableBashIntegration = true;

  programs.bash.shellAliases = {
    sloc = "scc -c --no-cocomo";
    archlinux = "docker run -it --rm --platform linux/amd64 archlinux";
    k = "kubecolor";
    ll = "eza -alh --group-directories-first";
    sts = "aws sts get-caller-identity";
    nixswitch = "darwin-rebuild switch --flake ~/.config/nix-darwin/.#";
    nixsearch = "nix search nixpkgs";
    nixup = "pushd ~/.config/nix-darwin; nix flake update; nixswitch; popd";
    gemini = "npx https://github.com/google-gemini/gemini-cli";
    claude = "npx @anthropic-ai/claude-code";
    assume = ". assume"; # configured in .granted/config
  };

  programs.bash.initExtra = ''
    PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
    shopt -s histappend

    # Minimal prompt showing just dirname
    PS1='\W \$ '

    # search bash history
    h () {
      rg -a --sort path "$@" ~/bash_history/
    }
  '';

  programs.starship.enable = false;
  programs.starship.enableBashIntegration = false;
  programs.starship.settings = {
    gcloud.disabled = true; # no email address
    git_commit.only_detached = false; # show hash of git commit
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "MesloLGS Nerd Font Mono";
        };
        size = 16;
      };
      selection = {
        save_to_clipboard = true;
      };
      cursor = {
        style = "Block";
        unfocused_hollow = true;
      };
    };
  };

}
