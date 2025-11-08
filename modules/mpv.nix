{lib, config, pkgs, ... }:
{
	programs.mpv = {
		enable = true;
		config = {
			volume = 40;
			hls-bitrate = "max";

			vo = "gpu";
			cache = "yes";
			glsl-shaders = "~/.config/mpv/shaders/FSRCNNX_x2_16-0-4-1.glsl";
			# glsl-shaders = "~/.config/mpv/shaders/nnedi3-nns128-win8x4.hook";

			# alpha = "yes";
			# background="0/0";
			# ytdl-format="bestvideo[ext=mp4][height<=?1080]+bestaudio[ext=m4a]";
			keep-open = "always";
		};
	};
}
