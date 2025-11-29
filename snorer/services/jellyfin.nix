{ ... }:
{
	services = {
		jellyfin = {
			enable = true;
			openFirewall = true;
			dataDir = "/mnt/storage/jellyfin";
		};
	};
	users.users.jellyfin = {
		# so i can access nextcloud users' music directories from jellyfin
		extraGroups = [ "nextcloud"  ];
	};
}
