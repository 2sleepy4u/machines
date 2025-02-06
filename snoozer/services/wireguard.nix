{ pkgs, ... }:
{
	networking.nat.enable = true;
	networking.nat.externalInterface = "eth0";
	networking.nat.internalInterfaces = [ "wg0" ];
	networking.firewall = {
		allowedUDPPorts = [ 51820 ];
	};

	networking.wireguard.interfaces = {
		wg0 = {
			ips = [ "172.17.172.1/24" ];
			listenPort = 51820;

			privateKey = "EK17R6/H6EIW8ovUhXUiIjx7IdQ8MtrllgHm6CBYfHA=";

			peers = [
			{ # Feel free to give a meaning full name
				publicKey = "e+5NivyQfvd6S4KfHoxFEifX3BtxwdADf96PxcU4SXo=";
				allowedIPs = [ "172.17.172.2/32" ];
				endpoint = "localhost:51820";
			}
			
			];
		};
	};
}
