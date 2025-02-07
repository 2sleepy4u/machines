{ config, pkgs, lib, ... }:
{
	environment.etc."nextcloud-admin-pass".text = "PWD";
	users.users.nginx = {
		group = "nginx";
		isSystemUser = true;
	};
	users.groups.nginx = {};
	# ensure that mysql is running *before* running the setup
	systemd.services."nextcloud-setup" = {
		requires = ["mysql.service"];
		after = ["mysql.service"];
	};
	services = {
		nginx.virtualHosts."cloud.onirya.it".listen = [ { addr = "192.168.1.250"; port = 8081; }];
		nginx.virtualHosts."onlyoffice.onirya.it".listen = [ { addr = "192.168.1.250"; port = 8082; }];
		nextcloud = {
			enable = true;
			package = pkgs.nextcloud30;
			hostName = "cloud.onirya.it";
			configureRedis = true;
			maxUploadSize = "16G";
			extraApps = with config.services.nextcloud.package.packages.apps; {
			# List of apps we want to install and are already packaged in
			# https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/nextcloud/packages/nextcloud-apps.json
				inherit calendar contacts mail notes onlyoffice tasks;
			};
			datadir = "/mnt/storage/nextcloud";
			config = {
				overwriteProtocol = "https";
				dbtype = "mysql";
				dbuser = "nextcloud";
				dbname = "nextcloud";
				# dbpassFile = "/mnt/storage/nextcloud/nextcloud-db-pass";
				adminuser = "root";
				adminpassFile = "/etc/nextcloud-admin-pass";
			};
		};
		mysql = {
			enable = true;
			package = pkgs.mariadb;
			ensureDatabases = [ "nextcloud" ];
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
	};
}
