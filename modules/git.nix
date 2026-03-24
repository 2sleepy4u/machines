{lib, config, pkgs, ... }:
{
	programs.git = {
		enable = true;
		userName = "riccardo.zancan";
		userEmail = "riccardo.zancan@aqc-industry.com";
		# config = {
		# 	diff.tool = "nvimdiff";
		# 	# difftool.neovim.cmd = "nvim -d $LOCAL $REMOTE";
		# };
	};
}
