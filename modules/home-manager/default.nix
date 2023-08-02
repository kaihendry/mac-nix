# https://nix-community.github.io/home-manager/options.html
{ pkgs, ... }: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    awscli2
    colima
    curl
    docker
    docker-compose
    duf
     (google-cloud-sdk.withExtraComponents # gcloud components list
      (with google-cloud-sdk.components; [
        gke-gcloud-auth-plugin
        gcloud-man-pages
      ])
    )
    kubectl
    fd
    pre-commit
    hugo
    gosec
    yajsv
    jq
    less
    nixpkgs-fmt
    ripgrep
    shellcheck
    tig
    watch
  ];
  home.sessionVariables = {
    HISTFILE = "$HOME/bash_history/$(date +%Y-%m)";
    PAGER = "less";
    CLICLOLOR = 1;
    PATH = "$PATH:$HOME/go/bin";
  };

  # https://nix-community.github.io/home-manager/options.html
  programs.zoxide = {
    enable = true;
    options = [ "--cmd j" ];
    enableBashIntegration = true;
  };

  # neovim with vim-fugitive
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    extraConfig = ''
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

    plugins = [
      {
        plugin = pkgs.vimPlugins.vim-nix;
      }
      {
        plugin = pkgs.vimPlugins.vim-fugitive;
      }
      {
        plugin = pkgs.vimPlugins.copilot-vim;
      }
      {
        plugin = pkgs.vimPlugins.vim-commentary;
      }
      {
        plugin = pkgs.vimPlugins.gitsigns-nvim;
        type = "lua";
        config = ''
          require('gitsigns').setup({})
        '';
      }
      {
        plugin = pkgs.vimPlugins.dracula-vim;
      }
    ];
  };


  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
  programs.exa.enable = true;
  programs.exa.enableAliases = true;

  programs.git = {
    enable = true;
    userName = "Kai Hendry";
    userEmail = "hendry@iki.fi";
    aliases = {
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      root = "rev-parse --show-toplevel";
    };
    extraConfig = {
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
    k = "kubectl";
    sts = "aws sts get-caller-identity";
    nixswitch = "darwin-rebuild switch --flake ~/mac-nix/.#";
    nixsearch = "nix search nixpkgs";
    nixup = "pushd ~/mac-nix; nix flake update; nixswitch; popd";
  };

  programs.bash.initExtra = ''
    PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
    shopt -s histappend

    # search bash history
    h () {
      rg -a "$@" ~/bash_history/*
    }
  '';

  programs.starship.enable = true;
  programs.starship.enableBashIntegration = true;

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

  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
  };
}
