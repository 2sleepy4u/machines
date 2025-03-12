{ lib, config, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ];

    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.supportedFilesystems = [ "ntfs" "hfs+" "hfsplus"];
	services.xserver.videoDrivers = [ "amdgpu" ];

	nix.settings.experimental-features = ["nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;
    nixpkgs.config.pulseaudio = true;

	programs.gamemode.enable = true;
    programs.steam.enable = true;
    programs.steam.remotePlay.openFirewall = true;
    programs.steam.gamescopeSession.enable = true;
	programs.steam.extraCompatPackages = with pkgs; [ proton-ge-bin ];


	users.users.rem = {
        isNormalUser = true;
        initialPassword = "123";
        extraGroups = [ "wheel" "audio" "networkmanager" "dialout" "usb" ];
        packages = with pkgs; [
			sof-firmware
			pciutils
			tree
			ripgrep
			tree
			usbutils
        ];
    };


	programs.hyprland.enable = true;

    hardware.opengl.enable = true;
    hardware.opengl.driSupport32Bit = true;
    hardware.enableAllFirmware = true;
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    services.openssh.enable = true;
    services.gvfs.enable = true;
    services.tumbler.enable = true;

	services.xserver.enable = true;
	services.displayManager.sddm = {
		enable = true;
		autoLogin.enable = true;
		autoLogin.user = "rem";
		theme = "catppuccin-mocha";
		package = pkgs.kdePackages.sddm;
	};

	security.pam.services.swaylock.text = ''auth Include login '';

	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
	};

	time.timeZone = "Europe/Rome";

	services.xserver.xkb.layout = "it";
    i18n.defaultLocale = "it_IT.UTF-8";
    console = {
        font = "Lat2-Terminus16";
        useXkbConfig = true; 
    };
    fonts.packages = with pkgs; [
		fira-code
		fira-code-symbols
		(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    ];




    networking.hostName = "REM"; 
    networking.networkmanager.enable = true;  
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 
        ];
        allowedUDPPorts = [
        ];
    };

    services.pipewire.enable = false;
    hardware.pulseaudio.enable = true;

    environment.systemPackages = with pkgs; [
		parted
        wget
        efibootmgr
        amdvlk
        vulkan-tools
        pciutils
        lsof
		xdg-desktop-portal-gtk
    ];

# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you
# accidentally delete configuration.nix.
# system.copySystemConfiguration = true;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It's perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.11"; # Did you read the comment?

}

