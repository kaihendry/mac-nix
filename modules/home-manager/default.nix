{ pkgs, ... }: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";

  home.packages = with pkgs; [ ripgrep fd jq curl less neovim duf zellij awscli2 nixpkgs-fmt tig hugo shellcheck ];
  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
    PATH = "$PATH:$HOME/go/bin";
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
    nixswitch = "darwin-rebuild switch --flake ~/mac-nix/.#";
    nixsearch = "nix search nixpkgs";
    nixup = "pushd ~/mac-nix; nix flake update; nixswitch; popd";
  };
  programs.starship.enable = true;
  programs.starship.enableBashIntegration = true;

  programs.alacritty = {
    enable = true;
    settings.font.normal.family = "MesloLGS Nerd Font Mono";
    settings.font.size = 16;
  };

  home.file = {
    ".gitconfig".source = ./dotfiles/gitconfig;
  };
}
