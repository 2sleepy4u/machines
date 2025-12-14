{ lib, ... }:
let 
  nixosDisk = "/dev/nvme0n1";
in
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = nixosDisk;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "128M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                subvolumes = {
                  "@root" = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd" "noatime" "space_cache=v2" "discard=async" ];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd" "noatime" "space_cache=v2" "discard=async" ];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime" "space_cache=v2" "discard=async" ];
                  };
                  "@snapshots" = {
                    mountpoint = "/.snapshots";
                    mountOptions = [ "compress=zstd" "noatime" "space_cache=v2" "discard=async" ];
                  };
                  "@swap" = {
                    mountpoint = "/.swap";
                    swap.swapfile.size = "8G";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
