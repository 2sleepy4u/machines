{ config, lib, pkgs, ... }:
{

	boot.supportedFilesystems = [ "zfs" ];
	boot.zfs.devNodes = "/dev/disk/by-path";
	boot.zfs.extraPools = [ "storage" ];
	networking.hostId = "4e98920d";
	services.zfs.autoScrub.enable = true;
	services.zfs.autoScrub.interval = "weekly";
	services.zfs.zed.enableMail = true;
	services.zfs.zed.settings = {
		ZED_DEBUG_LOG = "/tmp/zed.debug.log";
		ZED_EMAIL_ADDR = [ "riccardo.zancan00@gmail.com" ];
		ZED_EMAIL_PROG = "${pkgs.msmtp}/bin/msmtp";
		ZED_EMAIL_OPTS = "@ADDRESS@";

		ZED_NOTIFY_INTERVAL_SECS = 3600;
		ZED_NOTIFY_VERBOSE = true;

		ZED_USE_ENCLOSURE_LEDS = true;
		ZED_SCRUB_AFTER_RESILVER = true;
	};
}
