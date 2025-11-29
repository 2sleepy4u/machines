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
			label = {
				text = "cmd[update:1000] echo \"<span>$(date +\"%I:%M\")</span>\"";
				color = "rgba(216, 222, 233, 0.70)";
				font_size = 120;
				font_family = "SF Pro Display Bold";
				position = "0, 250";
				halign = "center";
				valign = "center";
			};

			input-field = [{
			 	size = "400, 100";
				outline_thickness = 2;
				dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
				dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
				dots_center = true;
				outer_color = "rgba(0, 0, 0, 0)";
				inner_color = "rgba(255, 255, 255, 0.1)";
				font_color = "rgb(200, 200, 200)";
				fade_on_empty = false;
				placeholder_text = "<i><span foreground=\"##ffffff99\">Enter Pass</span></i>";
				hide_input = false;
				position = "0, 0";
				halign = "center";
				valign = "center";
			}];

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
	services.dunst.settings = {
		global = {
			width = "(0, 300)";

			corner_radius = 8;           
			origin = "bottom-right";
			offset = "0x20";


			max_icon_size = 64;
			text_icon_padding = 0;

			word_wrap = "yes";
			ellipsize = "middle";
		};
	};

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
