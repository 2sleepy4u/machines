{ lib, config, pkgs, ... }:
{
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 3;
    boot.loader.efi.canTouchEfiVariables = true;

    nix.settings.experimental-features = ["nix-command" "flakes"];
	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
	};

    time.timeZone = "Europe/Rome";

	services.xserver.xkb.layout = "it";
    i18n.defaultLocale = "it_IT.UTF-8";
    console = {
        # font = "Lat2-Terminus16";
		font = "FiraCode";
        useXkbConfig = true; 
    };
    fonts.packages = with pkgs; [
		fira-code
		fira-code-symbols
		(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    ];

	programs.tmux.enable = true;
	programs.tmux.plugins = with pkgs.tmuxPlugins; [ 
		battery
		catppuccin
		resurrect
	];


	environment.sessionVariables = {
		EDITOR = "nvim";
	};

    networking.networkmanager.enable = true;  
    environment.systemPackages = with pkgs; [
		glow
		ffmpeg
		#kdePackages.qtwayland
		libheif
		libheif.out
		psmisc
		parted
        wget
        efibootmgr
        amdvlk
        vulkan-tools
		git
        neofetch
        pciutils
        lsof
		libsForQt5.qt5.qtquickcontrols2
		libsForQt5.qt5.qtgraphicaleffects
		xdg-desktop-portal-gtk
    ];
}
