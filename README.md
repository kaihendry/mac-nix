Requires: https://github.com/LnL7/nix-darwin


# Home manager not kicking in


	darwin-rebuild switch -I darwin-config=/Users/hendry/mac-nix/modules/darwin/default.nix 
	building the system configuration...
	Password:
	Sorry, try again.
	Password:
	user defaults...
	setting up user launchd services...
	Homebrew bundle...
	Using fujiapple852/trippy
	Using trippy
	Using maccy
	Using flameshot
	Homebrew Bundle complete! 4 Brewfile dependencies now installed.
	setting up /Applications/Nix Apps...
	setting up pam...
	applying patches...
	setting up /etc...
	error: not linking environment.etc."nix/nix.conf" because /etc/nix/nix.conf already exists, skipping...
	existing file has unknown content 549c6deb3684806cc4975a57d7a09330fe50e74ac710de8711f83ab799422360, move and activate again to apply
	system defaults...
	setting up launchd services...
	reloading nix-daemon...
	waiting for nix-daemon
	waiting for nix-daemon
	configuring networking...
	configuring keyboard...
	configuring fonts...
