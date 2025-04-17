{ pkgs, ... }: {
  # here go the darwin preferences and config items
  environment = {
    systemPackages = [ pkgs.coreutils ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
    variables.EDITOR = "nvim";
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    defaults = {
      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
        CreateDesktop = true;
        FXPreferredViewStyle = "Nlsv";
      };
      dock = {
        autohide = true;
        autohide-delay = 0.01;
        autohide-time-modifier = 0.01;
        show-recents = false;
      };
      CustomSystemPreferences = {
        NSGlobalDomain = {
          NSWindowShouldDragOnGesture = true;
        };
      };
      NSGlobalDomain = {
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.sound.beep.volume" = 0.0;
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        AppleShowAllExtensions = true;
        NSWindowResizeTime = 0.1;
        NSAutomaticWindowAnimationsEnabled = false;
      };
    };
    stateVersion = 4;
    activationScripts = {
      postActivation = {
        text = ''sudo chsh -s ${pkgs.bashInteractive}/bin/bash'';
      };
    };
  };
  security.pam.services.sudo_local.touchIdAuth = true;
  users.users.hendry.home = "/Users/hendry";
  networking = {
    hostName = "kaim1pro";
  };
  fonts.packages = [pkgs.nerd-fonts.meslo-lg];
  ids.gids.nixbld = 350;

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    # use home brew to install packages for spotlight to work
    casks = [ "raycast" "alacritty" "ghostty" "flameshot" ];
  };
}
