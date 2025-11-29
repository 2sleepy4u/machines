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
		settings = {
			global = {
				workgroup = "WORKGROUP";
				"server string" = "server";
				"netbios name" = "server";
				security = "user";
			};
			movies = {
				path = "/mnt/media/movies";
				browseable = "yes";
				"read only" = "no";
				"guest ok" = "yes";
			};
			music = {
				path = "/mnt/media/music";
				browseable = "yes";
				"read only" = "no";
				"guest ok" = "yes";
			};
		};
	};
}
