{pkgs}:
{
	users.users = {
		im2sleepy = {
			isNormalUser = true;
			initialPassword = "123";
			home = "/home/im2sleepy";
			extraGroups = [ "wheel" "networkmanager" ];
			packages = with pkgs; [
				git
				tmux
				pciutils
				neofetch
			];
		};
		ettore = {
			isNormalUser = true;
			initialPassword = "123";
			home = "/home/ettore";
			extraGroups = [ "samba" ];
		};
	};


}
