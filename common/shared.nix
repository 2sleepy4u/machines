{ lib, config, pkgs, ... }:
{

    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 3;
    boot.loader.efi.canTouchEfiVariables = true;

	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
	};

    networking.networkmanager.enable = true;  
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
        keyMap = "it";
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

	services.xserver.enable = true;
	services.displayManager.sddm.enable = true;

	security.pam.services.swaylock.text = ''auth Include login '';

    users.users.im2sleepy = {
        isNormalUser = true;
        initialPassword = "123";
        extraGroups = [ "wheel" "libvirtd" "audio" "networkmanager" "dialout" "usb"];
        packages = with pkgs; [
			figma-linux
			lldb
            cargo
            gh
			gcc
			#VFIO
			pciutils
			tree
			#pgadmin4
			ripgrep
			usbutils
					#iOS
            usbmuxd
            libusbmuxd
            libimobiledevice
            ifuse


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
        catppuccin-sddm.override {
            flavor = "mocha";
            font  = "Noto Sans";
            fontSize = "9";
            background = "${../pictures/eva02.png}";
            loginBackground = true;
        }
    ];
