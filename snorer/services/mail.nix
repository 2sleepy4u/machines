{...}:
{
  programs.msmtp = {
    enable = true;
    setSendmail = true;
    defaults = {
      aliases = "/etc/aliases";
      port = 465;
      tls_trust_file = "/etc/ssl/certs/ca-certificates.crt";
      tls = "on";
      # auth = "login";
	  auth = "on";
      tls_starttls = "off";
    };
    accounts = {
      default = {
        host = "in-v3.mailjet.com";
        passwordeval = "cat /mnt/storage/mail/emailpass.txt";
        user = "b807b3eebb085dd1e2cc3c6804e2a5ce";
        from = "noreply@onirya.it";
      };
    };
  };
}
