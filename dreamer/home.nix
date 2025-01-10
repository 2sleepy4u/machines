{ inputs, config, pkgs, ... }:
{
	imports = [
		inputs.nixvim.homeManagerModules.nixvim
		inputs.catppuccin.homeManagerModules.catppuccin
		../dreamer/nvim.nix
		../common/mpv.nix
		../common/git.nix
		./waybar.nix
		../common/wlogout.nix
	];

	home.stateVersion = "24.05";
	home.sessionVariables = {
		NIXOS_OZONE_WL = "1";
		EDITOR = "nvim";
	};
	programs.home-manager.enable = true;

	programs.brave.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
	programs.starship.enable = true;
	programs.alacritty.enable = true;
	programs.alacritty.catppuccin.enable = true;
	programs.alacritty.catppuccin.flavor = "mocha";
	programs.alacritty.settings = {
		window.opacity = 0.8;
	};


	gtk.enable = true;
	gtk.catppuccin.enable = true;
	services.dunst.enable = true;
	services.dunst.catppuccin.enable = true;
	services.dunst.catppuccin.flavor = "mocha";


	home.packages = with pkgs; [
		#programs
		brave
		spotify
		discord

		#gnome-network-displays

		#utility
		imv
		unzip
		pavucontrol
		#yt-dlp

		#custom
		#dunst
		#blueberry
		overskride
		networkmanagerapplet
		cliphist
		wl-clipboard
		grim
		slurp
		alacritty
		wpaperd
		wayvnc
		waybar
		playerctl
		#swaybg
		wofi
	];
}
