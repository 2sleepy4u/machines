{ lib, config, pkgs, ... }:
{
	programs.tmux = {
		enable = true;
		keyMode = "vi";
		shortcut = "a";
		extraConfig = ''
			unbind & 
			bind -r k kill-window

			unbind c 
			bind -r Enter new-window
			'';
		baseIndex = 1;
		plugins = with pkgs.tmuxPlugins; [ 
			battery
			catppuccin
			resurrect
			yank
		];
	};
}
