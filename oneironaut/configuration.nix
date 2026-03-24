{ lib, config, pkgs, nixvim, ... }:
{

    imports = [
		./hardware-configuration.nix
	];

    boot.kernelModules = [ "i915"  "snd_hda_intel" "snd_soc_skl"];
    boot.supportedFilesystems = [ "ntfs" "hfs+" "hfsplus"];
    boot.kernelParams = [ "i915.force_probe=7d55" ]; 
	boot.kernelPackages = pkgs.linuxPackages_6_18;
	boot.extraModprobeConfig = ''
		options snd-hda-intel model=dell-headset-multi
	'';

	services.udev.packages = [ pkgs.probe-rs-tools ];
	services.udev.extraRules = ''SUBSYSTEM=="hidraw", MODE="0666"'';
	services.kmonad = {
		enable = true;
		keyboards.myKeyboard = {
			device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";  # your actual device
			config = builtins.readFile ../config/neotokyoiii.kbd;
		};
	};
	services.pulseaudio.enable = false;
	programs.xwayland.enable = true;
	programs.adb.enable = true;

	hardware.probe-rs.enable = true;

	services.pipewire = {
		enable = true;
		alsa.enable = true;
		pulse.enable = true;
	};
	xdg.portal = {
		enable = true;
		wlr.enable = false;
		extraPortals = with pkgs; [ 
			xdg-desktop-portal-gtk 
			xdg-desktop-portal-gnome 
			xdg-desktop-portal-wlr 
			xdg-desktop-portal-hyprland
		];
		config.common = {};
	};

	programs.nix-ld.enable = true;
	programs.direnv = {
		enable = true;
		nix-direnv.enable = true;
	};

	services.postgresql.enable = true;
	services.flatpak.enable = true;

	services.pgadmin = {
		enable = false;
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


	networking.hostName = "AQC-TS-03"; # Define your hostname.
	networking.networkmanager.enable = true;  
	networking.firewall = {
		enable = true;
		allowedTCPPorts = [ 
			3333
            57621
            4840
            4855
			5900
			5050
			8000
			4222  # NATS client port
			8222  # NATS monitoring port (optional)
        ];
        allowedUDPPorts = [
            5353
            4840
            4855
			5900
			5050
        ];
    };


	nix.settings.experimental-features = ["nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;
	hardware.enableAllFirmware = true;
	hardware.enableRedistributableFirmware = true; 
	hardware.ipu6.enable = true;
	hardware.ipu6.platform = "ipu6epmtl";
	

    programs.starship.enable = true;
    services.openssh.enable = true;

	services.nats = {
		enable = true;
		jetstream = true;
		port = 4222;
		settings = {
			host = "0.0.0.0";
			# host = "192.168.30.103";
			#host = "192.168.12.1";
			# port = "4222";
			max_payload = 16777216;
			http_port = 8222; 
		};
	};

	programs.fzf.keybindings = true;
	programs.fzf.fuzzyCompletion = true;


	users.defaultUserShell = pkgs.zsh;
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
	};

	virtualisation.docker.enable = true;

    users.users.riccardo = {
        isNormalUser = true;
        initialPassword = "123";
        extraGroups = [ "wheel" "libvirtd" "audio" "networkmanager" "dialout" "usb" "docker" "plugdev" "adbusers"];
        packages = with pkgs; [
			xclip
			slint-lsp
			fzf
			virt-manager
			sof-firmware
			lldb
            gh
			gcc
			pciutils
			tree
			ripgrep
			usbutils
			docker
			direnv
vim
        ];
    };

	environment.pathsToLink = [ "share/thumbnailers" ];

	
  system.stateVersion = "25.11"; # Did you read the comment?
}
