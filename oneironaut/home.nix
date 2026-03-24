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

	home.stateVersion = "25.11";
	home.sessionVariables = {
		NIXOS_OZONE_WL = "1";
		EDITOR = "nvim";
	};
	programs.home-manager.enable = true;


	programs.brave.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform-hint=wayland";
	programs.starship.enable = true;
	programs.alacritty = {
		enable = true;
		catppuccin.enable = true;
		catppuccin.flavor = "mocha";
		# settings = {
		# 	window.opacity = 0.8;
		# };
	};

	programs.hyprlock = {
		enable = true;
		catppuccin.enable = true;
		catppuccin.flavor = "mocha";
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
				placeholder_text = "<i>Locked</i>";
				shadow_passes = 2;
			}
			];
		};
	};

	gtk.enable = true;
	gtk.catppuccin.enable = true;
	gtk.catppuccin.icon.enable = true;

	services.dunst.enable = true;
	services.dunst.catppuccin.enable = true;
	services.dunst.catppuccin.flavor = "mocha";

	programs.eww.enable = true;

	xdg = {
		desktopEntries = {
			thunar = {
				name = "Files";
				exec = "thunar %F";
				icon = "folder";
				terminal = false;
			};
		};
#TODO check this
		systemDirs.data = [
			"/var/lib/flatpak/exports/share"
			"$HOME/.local/share/flatpak/exports/share"
			"/usr/local/share"
			"/usr/share"
		];
		configFile = {
			"eww" = {
				source =  ./../dotfiles/eww;
				recursive = true;
			};
		};
	};

	home.packages = with pkgs; [
		(import ../scripts/fuzzy-finder.nix {
			inherit pkgs; 
			inherit lib;
			dir_list = [ "~/dev" ];
			fixed_dir_list = [ "~/"  "~/machines" ];
		})
		#programs
		eww
		brave
		gnome-calculator

		gemini-cli
		claude-code

		direnv
		xfce.thunar
		xwayland-satellite
		xwayland
		xwayland-run

		gnome-network-displays
		brightnessctl

		#utility
		imv
		unzip
		pavucontrol
		overskride
		networkmanagerapplet
		cliphist
		wl-clipboard
		grim
		slurp
		alacritty
		wpaperd
		playerctl
		wofi
		fuzzel
		claude-code
		# pgadmin6-desktopmode

		# spotify

		#work
		slack
		openvpn
		openfortivpn
		#notion-app
		chromium
	];
}
