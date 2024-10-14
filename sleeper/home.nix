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

	home.stateVersion = "23.11";
	home.sessionVariables = {
		NIXOS_OZONE_WL = "1";
		EDITOR = "nvim";
		#STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
	};
	programs.home-manager.enable = true;

	programs.brave.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";


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
		#yt-dlp

		#iOS
		#usbmuxd
		#libusbmuxd

		#custom
		gnome.nautilus
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
