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
	virtualisation.oci-containers.containers.onlyoffice =  {
		image = "onlyoffice/documentserver:latest";
		ports = ["8000:80"];
		environmentFiles = [
		# config.age.secrets.onlyofficeDocumentServerKey.path
		];
	};

	services = {
		nginx.virtualHosts."cloud.onirya.it".listen = [ { addr = "192.168.1.250"; port = 8081; }];
		# nginx.virtualHosts."onlyoffice.onirya.it".listen = [ { addr = "192.168.1.250"; port = 8082; }];
		nextcloud = {
			enable = true;
			package = pkgs.nextcloud30;
			hostName = "cloud.onirya.it";
			configureRedis = true;
			maxUploadSize = "16G";
			extraApps = with config.services.nextcloud.package.packages.apps; {
			# List of apps we want to install and are already packaged in
			# https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/nextcloud/packages/nextcloud-apps.json
				inherit calendar contacts mail notes onlyoffice tasks previewgenerator;
			};
			datadir = "/mnt/storage/nextcloud";
			settings = {
				mail_smtpmode = "sendmail";
				mail_sendmailmode = "pipe";
				trusted_domains = [ "192.168.1.250" "cloud.onirya.it"];
				trusted_proxies = [ "192.168.1.250" ];
				enable_previews = true;
				preview_ffmpeg_path = "${pkgs.ffmpeg}/bin";
				enabledPreviewProviders = [
					  "OC\\Preview\\BMP"
					  "OC\\Preview\\GIF"
					  "OC\\Preview\\JPEG"
					  "OC\\Preview\\Krita"
					  "OC\\Preview\\MarkDown"
					  "OC\\Preview\\MP3"
					  "OC\\Preview\\MP4"
					  "OC\\Preview\\Movie"
					  "OC\\Preview\\MOV"
					  "OC\\Preview\\OpenDocument"
					  "OC\\Preview\\PNG"
					  "OC\\Preview\\TXT"
					  "OC\\Preview\\XBitmap"
					  "OC\\Preview\\HEIC"
				  ];
			};
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
			enable = false;
			hostname = "onlyoffice.onirya.it";
			jwtSecretFile = "";
		};
	};
}
