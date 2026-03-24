{pkgs, ...}:
{
	nixpkgs.config.allowUnfree = true;
    #nixpkgs.config.pulseaudio = true;

	programs.niri.enable = true;

    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;
    hardware.enableAllFirmware = true;
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;


	programs.ssh.askPassword = "";

    services.printing.enable = true;
    services.avahi.enable = true;
    services.avahi.nssmdns4 = true;
    services.avahi.openFirewall = true;
    services.openssh.enable = true;
    services.gvfs.enable = true;
    services.tumbler.enable = true;

	services.xserver.enable = true;
	services.xserver.windowManager.openbox.enable = true;
	services.displayManager.sddm = {
		enable = true;
		theme = "catppuccin-mocha-mauve";
		package = pkgs.kdePackages.sddm;
	};

	# programs.hyprlock.enable = true;

	security.pam.services.swaylock.text = ''auth Include login '';

	environment.pathsToLink = [ "share/thumbnailers" ];

}
