{}:
{
	boot.supportedFilesystems = [ "zfs" ];
	boot.zfs.forceImportRoot = false;
	networking.hostId = "4e98920d";
	services.zfs.autoScrub.enable = true;
	services.zfs.zed.enableMail = true;
	services.zfs.zed.settings = {
		ZED_EMAIL_ADDR = [ "root" ];
		ZED_NOTIFY_VERBOSE = true;
	};
}
