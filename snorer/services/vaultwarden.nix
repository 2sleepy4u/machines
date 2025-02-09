{ ... }:
{
	services.vaultwarden = {
		enable = true;
		config = {
			ROCKET_ADDRESS = "192.168.1.250";
			ROCKET_PORT = 8222;
		};
	};
}
