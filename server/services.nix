{ config, pkgs, ... }:
{
	services = {
#nginx.virtualHosts."cloud.onirya.it".listen = [ { addr = "192.168.1.250"; port = 8081; }];
		nextcloud = {
			enable = false;
			package = pkgs.nextcloud28;
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
#defaultPhoneRegion = "PT";
				dbtype = "mysql";
				dbpassFile = "/server/nextcloud-db-pass";
				adminuser = "root";
				adminpassFile = "/server/nextcloud-pass";
			};
		};
		mysql = {
			enable = false;
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
			enable = false;
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
		tailscale.enable = true;
		jellyfin = {
			enable = true;
			openFirewall = true;
		};
		cron = {
			enable = true;
			systemCronJobs = [
				"0 3 * * 1    root    rsync -Aavx /docker/nextcloud /backup/nextcloud_$(date +\"date +\"%d_%m_%Y\")\" "
					"10 3 1 * *    root    rsync -Aavx /docker/nextcloud /backup/nextcloud_$(date +\"date +\"%m_%Y\")\" "
			];
		};
	};
}
