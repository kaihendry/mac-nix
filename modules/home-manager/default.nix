{ pkgs, ... }: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";
  # specify my home-manager configs
  home.packages = with pkgs; [ ripgrep fd curl less neovim duf zellij ];
  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };
  # https://nix-community.github.io/home-manager/options.html
  programs.zoxide = {
    enable = true;
    options = ["--cmd j"];
enableBashIntegration = true;
enableZshIntegration = true;
  };
  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
  programs.fzf.enableZshIntegration = true;
  programs.exa.enable = true;
  programs.exa.enableAliases = true;
  programs.git.enable = true;
  programs.zsh.enable = true;
  programs.bash.enable = true;
  programs.bash.enableCompletion = true;
  programs.bash.shellAliases = {
    nixswitch = "darwin-rebuild switch --flake ~/mac-nix/.#";
    nixup = "pushd ~/mac-nix; nix flake update; nixswitch; popd";
  };
  programs.starship.enable = true;
  programs.starship.enableBashIntegration = true;
  programs.starship.enableZshIntegration = true;
  programs.alacritty = {
    enable = true;
    settings.font.normal.family = "MesloLGS Nerd Font Mono";
    settings.font.size = 16;
    settings = {
      shell = {
        program = "${pkgs.zellij}/bin/zellij";
        args = [
          "options"
          "--default-shell"
          "/run/current-system/sw/bin/bash"
        ];
      };


        key_bindings = [
  { key= "N";         mods= "Command";      action= "SpawnNewInstance";       }
  { key= "Space";     mods= "Alt";          chars= " ";                     }
  { key= "Back"; mods= "Super"; chars= "\x15"; } 
  { key= "Left";     mods= "Alt";     chars= "\x1bb";                       }
  { key= "Right";    mods= "Alt";     chars= "\x1bf";                       }
  { key= "Left";     mods= "Command"; chars= "\x1bOH";   mode= "AppCursor";   }
  { key= "Right";    mods= "Command"; chars= "\x1bOF";   mode= "AppCursor";   }
	];


	};
  };
 home.file = {
	".inputrc".source = ./dotfiles/inputrc;
        ".gitconfig".source = ./dotfiles/gitconfig;
	  };
}
