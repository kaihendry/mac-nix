switch:
	nix run nix-darwin -- switch --flake ~/.config/nix-darwin

vibe: # npm i -g @openai/codex
	codex --approval-mode full-auto "Please improve this nix-darwin configuration"
