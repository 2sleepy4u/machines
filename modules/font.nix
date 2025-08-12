{ pkgs, ... }:
{
	fonts.packages = with pkgs; [
		google-fonts
			fira-code
			fira-code-symbols
			nerd-fonts.fira-code
			nerd-fonts.droid-sans-mono
			nerd-fonts.jetbrains-mono
			comic-mono
			font-awesome
	];
}
