{ inputs, config, pkgs, ... }:
{
	imports =
		[ # Include the results of the hardware scan.
		../common/configuration.nix
		./hardware-configuration.nix
		./caddy.nix
		./samba.nix
		./network.nix
		./services.nix
		./users.nix
		#inputs.nix-minecraft-nixosModules.minecraft-servers
		inputs.nixvim.nixosModules.nixvim
		../common/nvim.nix
		];

	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	catppuccin.enable = true;
	catppuccin.flavor = "mocha";

	programs.starship.enable = true;

	virtualisation.docker.enable = true;

	environment.interactiveShellInit = '' alias wakemeup="wol 04:7c:16:df:8e:b2" '';
	environment.systemPackages = with pkgs; [
			nmap
			docker
			arion
			tailscale
			git
			(python3.withPackages(ps: with ps; [ beautifulsoup4 ] ))
			cifs-utils
			rcon
			wget
			wol
			xdg-desktop-portal-gtk
	];

	environment.variables.EDITOR = "nvim";

	environment.etc."nextcloud-admin-pass".text = "test123";

	system.stateVersion = "23.11"; # Did you read the comment?

}
