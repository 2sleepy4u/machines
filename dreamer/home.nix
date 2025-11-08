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

	home.stateVersion = "25.05";
	home.sessionVariables = {
		NIXOS_OZONE_WL = "1";
		EDITOR = "nvim";
	};
	home.file = {
		".vst3/Vital.vst3" = {
			source = "${pkgs.vital}/lib/vst3/Vital.vst3";
		};
		".vst3/Surge.vst3" = {
			source = "${pkgs.surge}/lib/vst3/Surge.vst3";
		};
	};
	programs.home-manager.enable = true;

	programs.brave.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform-hint=wayland";
	programs.starship.enable = true;
	programs.alacritty.enable = true;
	programs.alacritty.catppuccin.enable = true;
	programs.alacritty.catppuccin.flavor = "mocha";
	programs.alacritty.settings = {
		window.opacity = 0.8;
	};

	programs.hyprlock = {
		enable = true;
		settings = {
			background = [
			{
				path = "screenshot";
				blur_passes = 3;
				blur_size = 7;
			}
			];

			input-field = [
			{
				size = "400, 100";
				position = "0, 0";
				monitor = "";
				dots_center = true;
				fade_on_empty = false;
				outline_thickness = 5;
				placeholder_text = "<i>Password...</i>";
				shadow_passes = 2;
			}
			];
		};
		};
	programs.hyprlock.catppuccin.enable = true;
	programs.hyprlock.catppuccin.flavor = "mocha";

	gtk.enable = true;
	gtk.catppuccin.enable = true;
	gtk.catppuccin.icon.enable = true;
	services.dunst.enable = true;
	services.dunst.catppuccin.enable = true;
	services.dunst.catppuccin.flavor = "mocha";

	programs.eww.enable = true;
	xdg.desktopEntries = {
		thunar = {
			name = "Files";
			exec = "thunar %F";
			icon = "folder";
			terminal = false;
		};
	};
	xdg.configFile = {
		"eww" = {
			source =  ./../dotfiles/eww;
			recursive = true;
		};
    };

	home.packages = with pkgs; [
		newsflash
		#music
		reaper
		jack2
		#VST
		vital
		surge
		surge-XT
		wine
		winetricks
		yabridge
		yabridgectl


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
