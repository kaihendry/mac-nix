{ pkgs, ... }: {
  # here go the darwin preferences and config items
  programs.bash.enable = true;
  environment = {
    systemPackages = [ pkgs.coreutils ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  users.users.hendry.home = "/Users/hendry";

  networking = {
    hostName = "kaim1pro";
  };


  fonts.fontDir.enable = true;
  fonts.fonts = [ (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; }) ];
  services.nix-daemon.enable = true;
  system = {
    defaults = {
      finder.AppleShowAllExtensions = true;
      finder._FXShowPosixPathInTitle = true;
      dock.autohide = true;

      NSGlobalDomain = {
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.sound.beep.volume" = 0.0;
        # allow key repeat
        ApplePressAndHoldEnabled = false;
        # delay before repeating keystrokes
        InitialKeyRepeat = 15; # normal minimum is 15 (225 ms)
        # delay between repeated keystrokes upon holding a key
        KeyRepeat = 2; # normal minimum is 2 (30 ms)
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "Automatic";
      };
    };
    # backwards compat; don't change
    stateVersion = 4;

    activationScripts.postActivation.text = ''sudo chsh -s ${pkgs.bashInteractive}/bin/bash''; # Since it's not possible to declare default shell, run this command after build

  };

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    # use home brew to install packages for spotlight to work
    brews = [
      "aws-sam-cli"
    ];
    casks = [ "maccy" "flameshot" "visual-studio-code" "alacritty" ];
  };
}
