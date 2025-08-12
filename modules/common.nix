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

	environment.sessionVariables = {
		EDITOR = "nvim";
	};

    environment.systemPackages = with pkgs; [
		glow
		catppuccin-sddm
		pulseaudio
		(import ../scripts/fuzzy-finder.nix { inherit pkgs; inherit lib; })
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
        amdvlk
        vulkan-tools
		git
        neofetch
        pciutils
        lsof
		libsForQt5.qt5.qtquickcontrols2
		libsForQt5.qt5.qtgraphicaleffects
		xdg-desktop-portal-gtk
		fzf
    ];
}
