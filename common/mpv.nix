{lib, config, pkgs, ... }:
{
	programs.mpv = {
		enable = true;
		config = {
			volume = 40;
			hls-bitrate = "max";
			cache = "yes";
			alpha = "yes";
			background="0/0";
			ytdl-format="bestvideo[ext=mp4][height<=?1080]+bestaudio[ext=m4a]";
			keep-open = "always";
		};
	};
}
