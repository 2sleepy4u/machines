{ inputs, config, pkgs, ... }:
{
	networking = {
		hostName = "dreamy-server";
		interfaces.enp1s0.ipv4.addresses = [{
			address = "192.168.1.250";
			prefixLength = 24;
		}];
		defaultGateway = "192.168.1.1";
		nameservers = [ "192.168.1.1" ];
		networkmanager.enable = true;
		firewall = {
			allowedTCPPorts = [
				80 443
#ftp
					20 21
					8222
					4822
					8080
					5432
			];
			allowedUDPPorts = [
				8222
					4822
					8080
					51820
			];
		};
	};
}
