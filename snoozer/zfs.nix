{}:
{
	boot.supportedFilesystems = [ "zfs" ];
	boot.zfs.forceImportRoot = false;
	services.zfs.zed.enableMail = true;
	services.zfs.zed.settings = {
		ZED_EMAIL_ADDR = [ "root" ];
		ZED_NOTIFY_VERBOSE = true;
	};
}
