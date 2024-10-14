{ lib, config, pkgs, ... }:
{
    imports =
        [ 
        ./hardware-configuration.nix
        ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 3;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.supportedFilesystems = [ "ntfs" "hfs+" "hfsplus"];

	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
	};

    networking.hostName = "dreamer"; 
    networking.networkmanager.enable = true;  
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 
            #spotify
            57621
            4840
            4855
			5900
			5432
        ];
        allowedUDPPorts = [
            #spotify
            5353
            4840
            4855
			5900
        ];
    };

    time.timeZone = "Europe/Rome";

    nix.settings.experimental-features = ["nix-command" "flakes"];
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.pulseaudio = true;

    programs.hyprland.enable = true;

    hardware.opengl.enable = true;
    hardware.opengl.driSupport = true;
    hardware.opengl.driSupport32Bit = true;
    hardware.enableAllFirmware = true;
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    hardware.pulseaudio.enable = true;
	sound.enable = true;

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

    services.printing.enable = true;
    services.avahi.enable = true;
    services.avahi.nssmdns4 = true;
    services.avahi.openFirewall = true;
    services.openssh.enable = true;
    services.gvfs.enable = true;
    services.tumbler.enable = true;

	# This variable fixes electron apps in wayland
	#environment.sessionVariables.NIXOS_OZONE_WL = "1"; 
	#environment.variables.EDITOR = "neovim";

    users.users.im2sleepy = {
        isNormalUser = true;
        initialPassword = "123";
        extraGroups = [ "wheel" "libvirtd" "audio" "networkmanager" "dialout" "usb"];
        packages = with pkgs; [
			lldb
            cargo
            gh
			gcc
			pciutils
			tree
			ripgrep
			usbutils
        ];
    };

    environment.systemPackages = with pkgs; [
		parted
        wget
        efibootmgr
        amdvlk
        vulkan-tools
		git
		wayvnc
        neofetch
        pciutils
        lsof
		libsForQt5.qt5.qtquickcontrols2
		libsForQt5.qt5.qtgraphicaleffects
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
    system.stateVersion = "24.05"; # Did you read the comment?
}

