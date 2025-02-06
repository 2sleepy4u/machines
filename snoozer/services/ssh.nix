{ ... }:
{
	openssh = {
		enable = true;
		settings = {
			PasswordAuthentication = true;
			# KbdInteractiveAuthentication = false;
			AllowUsers = [ "im2sleepy" ]; 
			UseDns = true;
			X11Forwarding = true;
			PermitRootLogin = "no";
		};
	};
}
