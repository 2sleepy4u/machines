{lib, config, pkgs, ... }:
{
	programs.git = {
		enable = true;
		userName = "2sleepy4u";
		userEmail = "riccardo.zancan00@gmail.com";
		config = {
			diff.tool = "nvimdiff";
			# difftool.neovim.cmd = "nvim -d $LOCAL $REMOTE";
		};
	};
}
