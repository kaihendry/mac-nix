{ pkgs, ... }: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";
  # specify my home-manager configs
  home.packages = with pkgs; [ ripgrep fd curl less neovim duf ];
  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };
  # https://nix-community.github.io/home-manager/options.html
  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration = true;
  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
  programs.exa.enable = true;
  programs.git.enable = true;
  programs.bash.enable = true;
  programs.bash.enableCompletion = true;
  programs.bash.shellAliases = {
    ls = "ls --color=auto -F";
    ll = "exa -alh";
    nixswitch = "darwin-rebuild switch --flake ~/mac-nix/.#";
    nixup = "pushd ~/mac-nix; nix flake update; nixswitch; popd";
  };
  programs.starship.enable = true;
  programs.starship.enableBashIntegration = true;
  programs.alacritty = {
    enable = true;
    settings.font.normal.family = "MesloLGS Nerd Font Mono";
    settings.font.size = 16;
  };
  home.file.".inputrc".source = ./dotfiles/inputrc;
}
