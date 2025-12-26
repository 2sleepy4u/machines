{ lib, config, pkgs, unstablePkgs, ... }:
{
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 3;
    boot.loader.efi.canTouchEfiVariables = true;

    nix.settings.experimental-features = ["nix-command" "flakes"];

	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [ 
		xdg-desktop-portal-gtk 
		xdg-desktop-portal-hyprland
		];
	};

	environment.sessionVariables = {
		EDITOR = "nvim";
	};

    environment.systemPackages = with pkgs; [
		glow
			# catppuccin-sddm
		(catppuccin-sddm.override {
		 flavor = "mocha";
		 accent = "mauve";
		 # font  = "Noto Sans";
		 # fontSize = "9";
		 # background = "${./wallpaper.png}";
		 # loginBackground = true;
		 })
		pulseaudio
		(import ../scripts/fuzzy-finder.nix { inherit pkgs; inherit lib; dir_list = []; fixed_dir_list = [];})
		jdk
		libusb1
		ffmpeg
		#kdePackages.qtwayland
		libheif
		libheif.out
		psmisc
		parted
        wget
        efibootmgr
        # amdvlk
        vulkan-tools
		git
        neofetch
        pciutils
        lsof
		libsForQt5.qt5.qtquickcontrols2
		libsForQt5.qt5.qtgraphicaleffects
		xdg-desktop-portal-gtk
		xdg-desktop-portal-hyprland
		fzf
		catppuccin-cursors.mochaLight
		catppuccin-cursors.mochaDark
		steam-run
		unstablePkgs.winboat
    ];
}
