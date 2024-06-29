{ lib, config, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        #./vfio-gaming.nix
        ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 3;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.supportedFilesystems = [ "ntfs" "hfs+" "hfsplus"];
    #boot.extraModprobeConfig = '' options snd slots=snd-hda-ati '';

	/*
    nixpkgs.config.permittedInsecurePackages = [ "nix-2.16.2" ];

    services.postgresql = {
	    enable = true;
	    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all       all     trust
      host  all all 0.0.0.0/0 trust
    '';
    };
	*/

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

    time.timeZone = "Europe/Rome";

	nix.settings.experimental-features = ["nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;
    nixpkgs.config.pulseaudio = true;

	programs.kdeconnect.enable = true;
	programs.hyprland.enable = true;

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
    #specialisation."VFIO".configuration = {
        #system.nixos.tags = [ "with-vfio" ];
        #services.vfio-gaming = {
        #    enable = true;
        #    gpuIDs = ["1002:1478" "1002:1479" "1002:73ef" "1002:ab28"];
        #    #gpuIDs = ["1002:73ef"  "1002:ab28" ];
        #};
    #};



    services.printing.enable = true;
    services.avahi.enable = true;
    services.avahi.nssmdns4 = true;
    services.avahi.openFirewall = true;
    services.openssh.enable = true;
    services.gvfs.enable = true;
    services.tumbler.enable = true;

	services.xserver.enable = true;
	services.displayManager.sddm.enable = true;
	services.displayManager.sddm.theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
	#services.xserver.videoDrivers = [ "amdgpu" ];

	services.ollama = {
		enable = true;
	};

	# This variable fixes electron apps in wayland
	#environment.sessionVariables.NIXOS_OZONE_WL = "1"; 
	#environment.variables.EDITOR = "neovim";

	security.pam.services.swaylock = {
		text = ''
		auth Include login
		'';
	};


    users.users.im2sleepy = {
        isNormalUser = true;
        initialPassword = "123";
        extraGroups = [ "wheel" "libvirtd" "audio" "networkmanager" "postgres"];
        packages = with pkgs; [
            cargo
            gh
			gcc
			#VFIO
			pciutils
			tree
			pgadmin4
        ];
    };

# $ nix search wget
    environment.systemPackages = with pkgs; [
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

