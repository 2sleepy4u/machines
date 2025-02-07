{ ... }:
{
	services = {
		jellyfin = {
			enable = true;
			openFirewall = true;
			dataDir = "/mnt/storage/jellyfin";
		};
	};
}
