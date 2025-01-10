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

    networking.networkmanager.enable = true;  

    nix.settings.experimental-features = ["nix-command" "flakes"];
    nixpkgs.config.allowUnfree = true;
    hardware.enableAllFirmware = true;

    programs.starship.enable = true;
    services.openssh.enable = true;

    users.users.im2sleepy = {
        isNormalUser = true;
        initialPassword = "123";
        extraGroups = [ "wheel" "libvirtd" "audio" "networkmanager" "dialout" "usb" "docker"];
        packages = with pkgs; [
			sof-firmware
			lldb
            cargo
            gh
			gcc
			pciutils
			tree
			ripgrep
			usbutils
            tmux
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
    ];

  system.stateVersion = "24.05"; # Did you read the comment?
}
