{...}:
{
	# create derivation to add declaratively extra apps / plugins like zfs manager
	# then upload to nixpkgs
	services.cockpit = {
		enable = true;
		port = 9090;
		openFirewall = true; 
		settings = {
			WebService = {
				AllowUnencrypted = true;
			};
		};
	};
}
