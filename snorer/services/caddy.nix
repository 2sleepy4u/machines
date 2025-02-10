{ config, lib, pkgs, ... }:
{
	services.caddy = {
		enable = true;
		adapter = "caddyfile";
		extraConfig = ''
			https://cloud.onirya.it {
					log {
							format console
							output file /mnt/storage/caddy/cloud.log
					}
					reverse_proxy 192.168.1.250:8081
			}

			https://onlyoffice.onirya.it {
					reverse_proxy 192.168.1.250:8000
			}

			https://pwd.onirya.it  {
					log {
							format console
							output file /mnt/storage/caddy/pwd.log
					}
					reverse_proxy 192.168.1.250:8222
			}

			https://jelly.onirya.it  {
					log {
							format console
							output file /mnt/storage/caddy/jelly.log
					}
					reverse_proxy 192.168.1.250:8096
			}
	'';
	};
}
