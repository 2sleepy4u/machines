{ inputs, config, pkgs, ... }:
{
	imports = [
		inputs.nixvim.homeManagerModules.nixvim
		inputs.catppuccin.homeManagerModules.catppuccin
		./nvim.nix
		../common/mpv.nix
		../common/git.nix
		../common/waybar.nix
		../common/wlogout.nix
	];

	home.stateVersion = "23.11";
	home.sessionVariables = {
		NIXOS_OZONE_WL = "1";
		EDITOR = "nvim";
		#STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
	};
	programs.home-manager.enable = true;

	programs.brave.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";

	gtk.enable = true;
	gtk.catppuccin.enable = true;
	gtk.catppuccin.icon.enable = true;

	home.packages = with pkgs; [
		#programs
		brave
		firefox
		spotify
		discord

		#utility
		imv
		unzip
		pavucontrol
		gnome-network-displays
		#yt-dlp

		#iOS
		#usbmuxd
		#libusbmuxd

		#custom
		xfce.thunar
		wlogout
		dunst
		pavucontrol
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
		swaylock-effects
		wofi
		prismlauncher

		#gaming
		protonup
		mangohud
	];

}
