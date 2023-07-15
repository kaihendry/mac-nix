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
    fd
    hugo
    jq
    less
    neovim
    nixpkgs-fmt
    ripgrep
    shellcheck
    tig
    watch
    zellij
  ];
  home.sessionVariables = {
    HISTFILE = "$HOME/bash_history/$(date +%Y-%m)";
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
    PATH = "$PATH:$HOME/go/bin:/opt/homebrew/share/google-cloud-sdk/bin";
  };

  # https://nix-community.github.io/home-manager/options.html
  programs.zoxide = {
    enable = true;
    options = [ "--cmd j" ];
    enableBashIntegration = true;
  };

  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
  programs.exa.enable = true;
  programs.exa.enableAliases = true;
  programs.git.enable = true;
  programs.bash.enable = true;
  programs.bash.enableCompletion = true;

  programs.direnv.enable = true;
  programs.direnv.enableBashIntegration = true;

  programs.bash.shellAliases = {
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
    settings.font.normal.family = "MesloLGS Nerd Font Mono";
    settings.font.size = 16;
    settings.selection.saveToClipboard = true;
  };

  home.file = {
    ".gitconfig".source = ./dotfiles/gitconfig;
  };
}
