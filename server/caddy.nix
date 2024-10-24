{ config, lib, pkgs, ... }:
{
        services.caddy = {
                enable = true;
                adapter = "caddyfile";
                extraConfig = ''
                        https://cloud.onirya.it {
                                log {
                                        format console
                                        output file /server/caddy/caddy.log
                                }
                                reverse_proxy 192.168.1.250:8081
                        }

                        https://2sleepy.duckdns.org {
                                log {
                                        format console
                                        output file /server/caddy/caddy.log
                                }
                                reverse_proxy 192.168.1.250:8081
                        }
                        https://pwd.onirya.it  {
                                reverse_proxy 192.168.1.250:8222
                        }
                        https://100.65.28.131 {
                                reverse_proxy 192.168.1.250:8080
                        }
                '';
                };
}
