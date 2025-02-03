{ config, pkgs, ... }:
{
	services = {
#nginx.virtualHosts."cloud.onirya.it".listen = [ { addr = "192.168.1.250"; port = 8081; }];
		nextcloud = {
			enable = true;
			package = pkgs.nextcloud29;
			hostName = "cloud.onirya.it";
			configureRedis = true;
			maxUploadSize = "16G";
			extraApps = with config.services.nextcloud.package.packages.apps; {
			# List of apps we want to install and are already packaged in
			# https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/nextcloud/packages/nextcloud-apps.json
				inherit calendar contacts mail notes onlyoffice tasks;
			};
			config = {
				overwriteProtocol = "https";
				dbtype = "mysql";
				dbpassFile = "/server/nextcloud-db-pass";
				adminuser = "root";
				adminpassFile = "/server/nextcloud-pass";
			};
		};
		mysql = {
			enable = true;
			package = pkgs.mariadb;
			ensureUsers = [{
				name = "nextcloud";
				ensurePermissions = {
					"nextcloud.*" = "ALL PRIVILEGES";
				};
			}
			];
		};
		onlyoffice = {
			enable = true;
			hostname = "onlyoffice.onirya.it";
			jwtSecretFile = "";
		};
		vaultwarden = {
			enable = false;
			config = {
				ROCKET_ADDRESS = "192.168.1.250";
				ROCKET_PORT = 8222;
			};
		};
		openssh.enable = true;
		jellyfin = {
			enable = false;
			openFirewall = true;
		};
	};
}
