{ ... }:
{
	services.openssh = {
		enable = true;
		openFirewall = true;
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
