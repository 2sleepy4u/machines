{ lib, config, pkgs, ... }:
{
    imports =
        [ 
        ../common/shared.nix
        ./hardware-configuration.nix
        ];

    boot.supportedFilesystems = [ "ntfs" "hfs+" "hfsplus"];
    services.xserver.videoDrivers = [ "modesetting" ];
    boot.kernelModules = [ "i915" ];
    #nix-shell -p pciutils --run "lspci -nn | grep VGA"
    #to get device id [8086:<divice ID>]
    #boot.kernelParams = [ "i915.force_probe=<device ID>" ];
    hardware.opengl.extraPackags = with pkgs; [ vpl-gpu-rt ];
    #hardware.ipu6.enable = true;
    #hardware.ipu6.platform = "ipu6epmtl";

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

