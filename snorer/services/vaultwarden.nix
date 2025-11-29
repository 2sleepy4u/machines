{ pkgs, ... }:
{
	services.vaultwarden = {
		enable = true;
		#set ADMIN_TOKEN env var
		environmentFile = "/var/lib/vaultwarden/vaultwarden.env";
		config = {
			ROCKET_ADDRESS = "192.168.1.250";
			ROCKET_PORT = 8222;


			DOMAIN = "https://pwd.onirya.it";
			SIGNUPS_ALLOWED = false;
			INVITATIONS_ALLOWED = true;

			USE_SENDMAIL = true;
			SENDMAIL_COMMAND = "${pkgs.msmtp}/bin/msmtp";  # Direct path to msmtp

			SMTP_HOST = "localhost";
			SMTP_PORT = 465;
			SMTP_FROM = "noreply@onirya.it";
			SMTP_FROM_NAME = "Vaultwarden";
		};
	};
}
