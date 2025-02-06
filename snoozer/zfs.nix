{ config, lib, pkgs, ... }:
{

	/*
	fileSystems."/storage" = {
		device = "storage";
		fsType = "zfs";
	};

	fileSystems."/mnt/storage/nextcloud" = {
		device = "storage/nextcloud";
		fsType = "zfs";
	};

	fileSystems."/mnt/storage/jellyfin" = {
		device = "storage/jellyfin";
		fsType = "zfs";
	};
	*/

	boot.supportedFilesystems = [ "zfs" ];
	systemd.services.zfs-mount.enable = false;
	boot.zfs.forceImportRoot = false;
	# boot.zfs.devNodes = "/dev/sdX";
	boot.zfs.extraPools = [ "storage" ];
	networking.hostId = "4e98920d";
	services.zfs.autoScrub.enable = true;
	# services.zfs.zed.enableMail = true;
	services.zfs.zed.settings = {
		ZED_DEBUG_LOG = "/tmp/zed.debug.log";
		ZED_EMAIL_ADDR = [ "root" ];
		ZED_EMAIL_PROG = "${pkgs.msmtp}/bin/msmtp";
		ZED_EMAIL_OPTS = "@ADDRESS@";

		ZED_NOTIFY_INTERVAL_SECS = 3600;
		ZED_NOTIFY_VERBOSE = true;

		ZED_USE_ENCLOSURE_LEDS = true;
		ZED_SCRUB_AFTER_RESILVER = true;
	};
}
