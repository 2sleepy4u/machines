{ nixvim, pkgs, ... }:
{
	imports =
		[ # Include the results of the hardware scan.
		../common/configuration.nix
		./network.nix
		./users.nix
		./disk-config.nix
		./zfs.nix

		./services/caddy.nix
		./services/nextcloud.nix
		./services/jellyfin.nix
		./services/mail.nix
		./services/ssh.nix
		./services/cockpit.nix
		# ./services/samba.nix
		./services/vaultwarden.nix

		#inputs.nix-minecraft-nixosModules.minecraft-servers

		nixvim.nixosModules.nixvim
		../common/nvim.nix
		];

	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	nix.settings.trusted-users = [ "root" "@wheel" ];

	catppuccin.enable = true;
	catppuccin.flavor = "mocha";

	programs.starship.enable = true;

	environment.systemPackages = with pkgs; [
			nmap
			git
			cifs-utils
			rcon
			wget
			wol
			xdg-desktop-portal-gtk
	];

	environment.variables.EDITOR = "nvim";

	system.stateVersion = "24.11"; # Did you read the comment?
}
