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
	};


	programs.nix-ld.enable = true;

	services.postgresql.enable = true;
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
			nav = "cd && cd $(find * -maxdepth 3 -mindepth 1 -type d | fzf)";
			notes = "nvim $(find ~/doc -maxdepth 2 -mindepth 1 -type f | fzf --preview 'cat {}')";
		};
		enableCompletion = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
	};

	virtualisation.docker.enable = true;

    users.users.im2sleepy = {
        isNormalUser = true;
        initialPassword = "123";
        extraGroups = [ "wheel" "libvirtd" "audio" "networkmanager" "dialout" "usb" "docker"];
        packages = with pkgs; [
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
			edgedb
			direnv
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

	
  system.stateVersion = "24.05"; # Did you read the comment?
}
