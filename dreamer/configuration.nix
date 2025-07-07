{ lib, config, pkgs, ... }:
{
    imports =
        [ 
		../common/users.nix
		../common/desktop.nix
        ../common/configuration.nix
		../common/virt.nix
        ./hardware-configuration.nix
        ];


    boot.supportedFilesystems = [ "ntfs" "hfs+" "hfsplus"];
    services.xserver.videoDrivers = [ "modesetting" ];
    boot.kernelModules = [ "i915"  "snd_hda_intel" "snd_soc_skl"];
	services.udev.enable = true;
	services.udev.extraRules = ''
		SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3748", MODE="0666", GROUP="plugdev"
		SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="374b", MODE="0666", GROUP="plugdev"
		SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3752", MODE="0666", GROUP="plugdev"
		'';

    #nix-shell -p pciutils --run "lspci -nn | grep VGA"
    #to get device id [8086:<divice ID>]
	boot.kernelPackages = pkgs.linuxPackages_6_15;
    boot.kernelParams = [ "i915.force_probe=7d55" ]; 
	hardware.enableRedistributableFirmware = true; 
	hardware.graphics.extraPackages = with pkgs; [ vpl-gpu-rt ];
    hardware.pulseaudio.enable = false;
	services.ollama.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		pulse.enable = true;
	};

	users.defaultUserShell = pkgs.zsh;
	virtualisation.docker.enable = true;

    hardware.ipu6.enable = true;
	hardware.ipu6.platform = "ipu6epmtl";
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
	};

	services.usbmuxd = {
		enable = true;
		package = pkgs.usbmuxd2;
	};


	programs.kdeconnect = {
		enable = true;
		package = pkgs.kdePackages.kdeconnect-kde;
		#indicator = true;
	};
	services.fprintd.enable = true;

    networking.hostName = "dreamer"; 
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

