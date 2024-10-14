{ lib, config, pkgs, ... }:
{
    imports =
        [ 
        ../common/shared.nix
        ./hardware-configuration.nix
        ];

    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.supportedFilesystems = [ "ntfs" "hfs+" "hfsplus"];

    networking.hostName = "sleeper"; 
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

    programs.gamemode.enable = true;
    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
	programs.steam.extraCompatPackages = with pkgs; [ proton-ge-bin ];

	services.usbmuxd = {
		enable = true;
		package = pkgs.usbmuxd2;
	};

	services.displayManager.sddm.theme = "${import ../themes/sddm-sugar-dark.nix { inherit pkgs; }}";
	services.xserver.videoDrivers = [ "amdgpu" ];


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

