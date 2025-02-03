{ inputs, config, pkgs, ... }:
{
	imports =
		[ # Include the results of the hardware scan.
		../common/configuration.nix
		# ./hardware-configuration.nix
		./caddy.nix
		# ./samba.nix
		./network.nix
		./services.nix
		./users.nix
		#inputs.nix-minecraft-nixosModules.minecraft-servers
		inputs.nixvim.nixosModules.nixvim
		../common/nvim.nix
		];

	networking.hostId = "4e98920d";

	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
