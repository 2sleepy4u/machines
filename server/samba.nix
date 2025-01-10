{ config, pkgs, arion, ... }:
{
	services.samba-wsdd.enable = true; # make shares visible for windows 10 clients
	networking.firewall.allowedTCPPorts = [
	  5357 # wsdd
	];
	networking.firewall.allowedUDPPorts = [
	  3702 # wsdd
	];
	services.samba = {
		enable = true;
		openFirewall = true;
		securityType = "user";
		extraConfig = ''
			workgroup = WORKGROUP
			server string = server
			netbios name = server
			security = user
			'';
		shares = {
			im2sleepy = {
				path = "/server/jellyfin/2sleepy";
				browseable = "yes";
				"read only" = "no";
				"guest ok" = "yes";
			};
			music = {
				path = "/server/music";
				browseable = "yes";
				"read only" = "no";
				"guest ok" = "yes";
			};
		};
	};
}
