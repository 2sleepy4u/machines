{ lib, config, pkgs, nixvim, ... }:
{

    imports = [
        nixvim.nixosModules.nixvim
        #<nixos-wsl/modules>
		../common/configuration.nix
        ../common/nvim.nix
    ];

    boot.loader.systemd-boot.enable = lib.mkForce false;
	catppuccin.enable = true;
	catppuccin.flavor = "mocha";
	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
		config.common.default = "*";
	};


	programs.nix-ld.enable = true;

	services.postgresql.enable = true;
	services.pgadmin = {
		enable = true;
		initialEmail = "riccardo.zancan@aqc-industry.com";
		initialPasswordFile = ../pswd;
	};
	# prometheus.enable = true;
	services.prometheus = {
		enable = true;
		extraFlags = ["--enable-feature=otlp-write-receiver"];
		globalConfig.scrape_interval = "10s"; # "1m"
			scrapeConfigs = [
			{
				job_name = "node";
				static_configs = [{
					targets = [ "localhost:${toString 14269}" ];
				}];
			}
			];
	};

	programs.virt-manager.enable = true;
	users.groups.libvirtd.members = ["im2sleepy"];
	virtualisation.libvirtd.enable = true;
    networking.networkmanager.enable = true;  

    nix.settings.experimental-features = ["nix-command" "flakes"];
    nixpkgs.config.allowUnfree = true;
    hardware.enableAllFirmware = true;

    programs.starship.enable = true;
	programs.starship.settings = {
		palette = "catppuccin_mocha";
		palettes.catppuccin_mocha = {
		rosewater = "#f5e0dc";
		flamingo = "#f2cdcd";
		pink = "#f5c2e7";
		mauve = "#cba6f7";
		red = "#f38ba8";
		maroon = "#eba0ac";
		peach = "#fab387";
		yellow = "#f9e2af";
		green = "#a6e3a1";
		teal = "#94e2d5";
		sky = "#89dceb";
		sapphire = "#74c7ec";
		blue = "#89b4fa";
		lavender = "#b4befe";
		text = "#cdd6f4";
		subtext1 = "#bac2de";
		subtext0 = "#a6adc8";
		overlay2 = "#9399b2";
		overlay1 = "#7f849c";
		overlay0 = "#6c7086";
		surface2 = "#585b70";
		surface1 = "#45475a";
		surface0 = "#313244";
		base = "#1e1e2e";
		mantle = "#181825";
		crust = "#11111b";
		};
	};
    services.openssh.enable = true;

	services.nats = {
		enable = true;
	};

	programs.fzf.keybindings = true;
	programs.fzf.fuzzyCompletion = true;


	users.defaultUserShell = pkgs.zsh;
	programs.zsh = {
		enable = true;
		shellAliases = { 
			c = "xclip";
		};
		enableCompletion = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
		ohMyZsh = {
			enable = true;
			# theme = "catppuccin-mocha";
		};
	};

	virtualisation.docker.enable = true;

    users.users.im2sleepy = {
        isNormalUser = true;
        initialPassword = "123";
        extraGroups = [ "wheel" "libvirtd" "audio" "networkmanager" "dialout" "usb" "docker"];
        packages = with pkgs; [
			(import ../scripts/fuzzy-finder.nix { 
				inherit pkgs; 
				inherit lib; 
				dir_list = [ "~/dev" "~/doc" ];
				fixed_dir_list = [ "~/" "~/machines"];
			})
			(import ../scripts/white-snake.nix { 
				inherit pkgs; 
				inherit lib; 
				repo = "eFishery/dvt";
			})
			xclip
			slint-lsp
			fzf
			pgadmin4-desktopmode
			virt-manager
			sof-firmware
			lldb
            cargo
            gh
			gcc
			pciutils
			tree
			ripgrep
			usbutils
			docker
			nix-direnv
			direnv
			imv
        ];
    };

	environment.pathsToLink = [ "share/thumbnailers" ];
    environment.systemPackages = with pkgs; [
		psmisc
		parted
        wget
        efibootmgr
		git
		wayvnc
        neofetch
        pciutils
        lsof
		xdg-desktop-portal-gtk
		docker
    ];

  system.stateVersion = "25.05"; # Did you read the comment?
}
