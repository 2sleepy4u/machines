{ pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
	package = pkgs.nextcloud28;
    hostName = "nextcloud.local";
    #nginx.enable = true;
    config = {
      dbtype = "mysql";
      dbuser = "nextcloud";
      dbname = "nextcloud";
	  adminpassFile = "/etc/nextcloud-admin-pass";
      adminuser = "root";
    };
  };

  services.mysql = {
    enable = true;
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
     { name = "nextcloud";
       ensurePermissions = { "nextcloud.*" = "ALL PRIVILEGES";};

     }
    ];
    package = pkgs.mariadb;
  };

  # ensure that the db is running *before* running the setup
  systemd.services."nextcloud-setup" = {
    requires = ["mysql.service"];
    after = ["mysql.service"];
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}}
