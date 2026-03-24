{ pkgs, ... }:
{
	time.timeZone = "Europe/Rome";


	services.xserver.xkb.layout = "it";
	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		font = "Lat2-Terminus16";
		useXkbConfig = true; 
	};

}
