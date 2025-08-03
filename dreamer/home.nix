{ inputs, config, pkgs, ... }:
{
	imports = [
		inputs.nixvim.homeManagerModules.nixvim
		inputs.catppuccin.homeManagerModules.catppuccin
		../modules/nvim.nix
		../modules/mpv.nix
		../modules/git.nix
		../modules/wlogout.nix
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
	gtk.catppuccin.icon.enable = true;
	services.dunst.enable = true;
	services.dunst.catppuccin.enable = true;
	services.dunst.catppuccin.flavor = "mocha";

	programs.eww.enable = true;
	xdg.configFile = {
		"eww" = {
			source =  ./../dotfiles/eww;
			recursive = true;
		};
    };

	home.packages = with pkgs; [
		#programs
		eww
		brave
		spotify
		discord
		gnome-calculator

		direnv
		xfce.thunar

		gnome-network-displays
		brightnessctl

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
		# wayvnc
		playerctl
		#swaybg
		wofi
	];
}
