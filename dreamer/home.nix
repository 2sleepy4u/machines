{ inputs, config, pkgs, ... }:
{
	imports = [
		inputs.nixvim.homeManagerModules.nixvim
		../common/nvim.nix
		../common/mpv.nix
		../common/gtk.nix
		../common/git.nix
		../common/waybar.nix
		../common/wlogout.nix
	];

	home.stateVersion = "24.05";
	home.sessionVariables = {
		NIXOS_OZONE_WL = "1";
		EDITOR = "nvim";
	};
	programs.home-manager.enable = true;

	programs.brave.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";

	home.packages = with pkgs; [
		#programs
		brave
		spotify
		discord

		#utility
		imv
		unzip
		pavucontrol
		#yt-dlp

		#custom
		gnome.nautilus
		dunst
		blueberry
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
