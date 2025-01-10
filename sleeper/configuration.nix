
{ lib, config, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
		../common/gaming.nix
		../common/users.nix
		../common/desktop.nix
        ../common/configuration.nix
        ./hardware-configuration.nix
        ];

    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.supportedFilesystems = [ "ntfs" "hfs+" "hfsplus"];
	services.xserver.videoDrivers = [ "amdgpu" ];

	nix.settings.experimental-features = ["nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;
    nixpkgs.config.pulseaudio = true;

    networking.hostName = "sleeper"; 
    networking.networkmanager.enable = true;  
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 
            #spotify
			3333
            57621
            4840
            4855
			5900
        ];
        allowedUDPPorts = [
            #spotify
            5353
            4840
            4855
			5900
        ];
    };

    programs.kdeconnect.enable = true;

    services.pipewire.enable = false;
    hardware.pulseaudio.enable = true;

	services.usbmuxd = {
		enable = true;
		package = pkgs.usbmuxd2;
	};


	# This variable fixes electron apps in wayland
	#environment.sessionVariables.NIXOS_OZONE_WL = "1"; 
	#environment.variables.EDITOR = "neovim";


# $ nix search wget
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
    system.stateVersion = "23.11"; # Did you read the comment?

}

