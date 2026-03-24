{ lib, config, pkgs, unstablePkgs, ... }:
{
	imports =
		[ 
		./hardware-configuration.nix
		];


	services.postgresql = {
		enable = true;
		ensureDatabases = [ "im2sleepy" ];
		ensureUsers = [
		{
			name = "im2sleepy";
			ensureDBOwnership = true;
		}
		];
	};
	

    boot.supportedFilesystems = [ "ntfs" "hfs+" "hfsplus"];
    services.xserver.videoDrivers = [ "modesetting" ];
    boot.kernelModules = [ "i915"  "snd_hda_intel" "snd_soc_skl" "hid_multitouch" "i2c_hid_acpi"];
	services.udev.enable = true;
	services.udev.extraRules = ''
		SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3748", MODE="0666", GROUP="plugdev"
		SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="374b", MODE="0666", GROUP="plugdev"
		SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3752", MODE="0666", GROUP="plugdev"
		'';


    #nix-shell -p pciutils --run "lspci -nn | grep VGA"
    #to get device id [8086:<divice ID>]
	# boot.kernelPackages = pkgs.linuxPackages_6_18;
	boot.kernelPackages = pkgs.linuxPackages_6_18;
    boot.kernelParams = [ 
		"i915.force_probe=7d55" 
		"i2c_hid_acpi.probe_defer=1" 
		# "snd_hda_intel.patch=hda-jack-retask.fw" 
	];


	# hardware.firmware = [
	# 	(pkgs.writeTextDir "lib/firmware/hda-jack-retask.fw" ''
	# 	 [codec]
	# 	 0x10ec0256 0x00000000 0
	#
	# 	 [pincfg]
	# 	 0x19 0x03a11020
	# 	 0x1b 0x90a10130
	# 	 '')
	# ];

	# boot.extraModprobeConfig = "options snd-hda-intel model=headset-mic";

	hardware.enableRedistributableFirmware = true; 
	hardware.firmware = [
		pkgs.sof-firmware
	];

	hardware.graphics.extraPackages = with pkgs; [ vpl-gpu-rt ];
    services.pulseaudio.enable = true;
	# services.ollama.enable = true;
	services.pipewire = {
		enable = false;
		alsa.enable = true;
		pulse.enable = true;
		jack.enable = true;
		extraConfig.jack = {
			"92-low-latency" = {
				"context.properties" = {
				  "default.clock.rate" = 48000;
				  "default.clock.quantum" = 32;
				  "default.clock.min-quantum" = 32;
				  "default.clock.max-quantum" = 32;
				};
			};
		};
	};
	# services.jack = {
	# 	jackd.enable = true;
	# 	alsa.enable = true;
	# 	loopback = {
	# 		enable = true;
	# 	};
	# };

	# users.defaultUserShell = pkgs.zsh;
	virtualisation.docker.enable = true;

	systemd.services.reload-touchscreen = {
		description = "Reload touchscreen modules for Huawei MateBook 14";
		wantedBy = [ "multi-user.target" ];
		after = [ "systemd-modules-load.service" ];
		serviceConfig = {
			Type = "oneshot";
			ExecStart = "${pkgs.bash}/bin/bash -c \"${pkgs.kmod}/bin/modprobe -r hid_multitouch; ${pkgs.kmod}/bin/modprobe -r i2c_hid_acpi; sleep 2; ${pkgs.kmod}/bin/modprobe i2c_hid_acpi; ${pkgs.kmod}/bin/modprobe hid_multitouch\"";
			RemainAfterExit = true;
		};
	};

    hardware.ipu6.enable = true;
	hardware.ipu6.platform = "ipu6epmtl";
	
	services.usbmuxd = {
		enable = true;
		package = pkgs.usbmuxd2;
	};


	programs.kdeconnect = {
		enable = true;
		package = pkgs.kdePackages.kdeconnect-kde;
	};
	services.fprintd.enable = true;

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

