{pkgs, ...}:
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
			openssh.authorizedKeys.keys = [
				"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDR/NWQjEDsvugu8MafH0OwF7VJaq6GStO/aNOxuDmBeiSSzdkDzEdm54mbscRIy+kCfW6kspyLBH+htj9aS81oeEeyvjQxdtKPSYZJomcs1OBLl+c8mjZS8bSlt42YNWQhPx1fS0Emayh7UASVZ9ZFs2XfUpqyTTqntCDaLwaFPx3hr2Xxq7KpugLsMbqd6Y5EmQyH4uisqHjUbShe4Xvdu5q9ufxlzdF4ZNz+mh+r0msxSZFK/115Uq8bm6Qq6GtjF4eg2rAuL4OZ86dr10k7lSu72oCl670jdbSN0NdFSq1ag23HutP/V6ixlO4dqJsfsvsv4Ki+tJrCVand5KpAosay1hK4f6/P7NBTUn8fxMkvQLBZk0JdkzdfE6T1RqV/EMTJPURAabwS6E5xe4gMm42cQx6GI2P1H+sQlfqkTIJfb3EYrVRBJOsqS3VwbGNAKt+gE41pFgd+at2T7AeaStm5ZgrMuT+jcINdOdBi3mCGzyFVtRtK9s5eHlREWgM= im2sleepy"
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
