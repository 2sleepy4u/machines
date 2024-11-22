{ config, pkgs, ... }:

{
        imports =
                [ # Include the results of the hardware scan.
                ./hardware-configuration.nix
                ./caddy.nix
                ./samba.nix
                #./modules/wireguard.nix
                inputs.nix-minecraft-nixosModules.minecraft-servers
                ];

        nix.settings.experimental-features = [ "nix-command" "flakes" ];


        nixpkgs.config = {
        multilib.enable = true;
                        packageOverrides = pkgs: {
                                i386-linux = pkgs.pkgsCross.i686-linux;
                                lib32 = true;
                        };
        };

        boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        /*
        services.minecraft-server = {
                enable = true;
                eula = true;
                server = {
                        the-pond = {
                                enable = true;
                                package = pokgs.fabricServers.fabric-1_20
                        };
                };
        };
        */

        networking = {
                hostName = "dreamy-server";
                interfaces.enp1s0.ipv4.addresses = [{
                        address = "192.168.1.250";
                        prefixLength = 24;
                }];
                defaultGateway = "192.168.1.1";
                nameservers = [ "192.168.1.1" ];
                #networkmanager.enable = true;
                firewall = {
                        allowedTCPPorts = [
                                80 443
                        #ftp
                                20 21
                                8222
                                4822
                                #32469
                                8080
                                5432
                        ];
                        allowedUDPPorts = [
                        #project zomboid
                                16261 16262 16263
                                #1900 5353
                                8222
                                4822
                                8080
                                51820
                        ];
                };
        };

        time.timeZone = "Europe/Rome";

        i18n.defaultLocale = "it_IT.UTF-8";
        console = {
                font = "Lat2-Terminus16";
                useXkbConfig = true; # use xkbOptions in tty.
        };


        # Users
        users.users = {
                im2sleepy = {
                        isNormalUser = true;
                        home = "/home/2sleepy";
                        #extraGroups = [ "wheel" ];
                };
                ettore = {
                        isNormalUser = true;
                        home = "/home/ettore";
                        extraGroups = [ "samba" ];
                };
        };


        # Virtualization
        virtualisation.docker.enable = true;


        environment.interactiveShellInit = ''
                alias wakemeup="wol 04:7c:16:df:8e:b2"
        '';
        environment.systemPackages = with pkgs; [
                nmap
                neovim
                docker
                #unstable.guacamole-server
                #unstable.guacamole-client
                arion
                tailscale
                git
                (python3.withPackages(ps: with ps; [ beautifulsoup4 ] ))
                cifs-utils
                rcon
                wget
                wol
                #wireguard-tools
                #steamcmd
        ];

        environment.variables.EDITOR = "nvim";

        programs.neovim = {
                enable = true;
                viAlias = true;
                vimAlias = true;
                configure = {
                        customRC = ''
                                set autoindent
                                set tabstop=2
                                set shiftwidth=2
                                set number
                                '';
                };
        };


# List services that you want to enable:

        nixpkgs.config.allowUnfree = true;
        environment.etc."nextcloud-admin-pass".text = "test123";
        services.ollama.enable = true;
        services = {
                #nginx.virtualHosts."cloud.onirya.it".listen = [ { addr = "192.168.1.250"; port = 8081; }];
                nextcloud = {
                        enable = false;
                        package = pkgs.nextcloud28;
                        hostName = "cloud.onirya.it";
                        configureRedis = true;
                        maxUploadSize = "16G";
                        extraApps = with config.services.nextcloud.package.packages.apps; {
                        # List of apps we want to install and are already packaged in
                        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/nextcloud/packages/nextcloud-apps.json
                        inherit calendar contacts mail notes onlyoffice tasks;
                      };
                      config = {
                        overwriteProtocol = "https";
                        #defaultPhoneRegion = "PT";
                        dbtype = "mysql";
                        dbpassFile = "/server/nextcloud-db-pass";
                        adminuser = "root";
                        adminpassFile = "/server/nextcloud-pass";
                      };
                    };
                mysql = {
                  enable = false;
                  package = pkgs.mariadb;
                  ensureUsers = [{
                        name = "nextcloud";
                        ensurePermissions = {
                                "nextcloud.*" = "ALL PRIVILEGES";
                        };
                        }
                ];
                };
                onlyoffice = {
                      enable = false;
                      hostname = "onlyoffice.onirya.it";
                      jwtSecretFile = "";
                };
                guacamole-server = {
                        enable = false;
                        host = "192.168.1.250";
                        userMappingXml = "/server/guacamole/user-mapping.xml";
                        };
                guacamole-client = {
                        enable = false;
                        enableWebserver = true;
                        settings = {
                        guacd-hostname = "192.168.1.250";
                        };
                        };
                vaultwarden = {
                        enable = false;
                        config = {
                                ROCKET_ADDRESS = "192.168.1.250";
                                ROCKET_PORT = 8222;
                        };
                };
                openssh.enable = true;
                tailscale.enable = true;
                jellyfin = {
                        enable = true;
                        openFirewall = true;
                };
                plex = {
                        enable = false;
                        openFirewall = false;
                };
                cron = {
                        enable = true;
                        systemCronJobs = [
                                "0 3 * * 1    root    rsync -Aavx /docker/nextcloud /backup/nextcloud_$(date +\"date +\"%d_%m_%Y\")\" "
                                "10 3 1 * *    root    rsync -Aavx /docker/nextcloud /backup/nextcloud_$(date +\"date +\"%m_%Y\")\" "
                        ];
                };
        };

        system.stateVersion = "23.11"; # Did you read the comment?

}
