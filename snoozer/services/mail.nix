{}:
{
  #use mailjet
  programs.msmtp = {
    enable = true;
    setSendmail = true;
    defaults = {
      aliases = "/etc/aliases";
      port = 465;
      tls_trust_file = "/etc/ssl/certs/ca-certificates.crt";
      tls = "on";
      auth = "login";
      tls_starttls = "off";
    };
    accounts = {
      default = {
        host = "mail.example.com";
        passwordeval = "cat /etc/emailpass.txt";
        user = "user@example.com";
        from = "user@example.com";
      };
    };
  };
}
