{ lib, ... }:
{
  disko.devices = {
    disk = {
      nixos = {
        type = "disk";
        # device = "/dev/nvme0n1";
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
			boot = {
				name = "boot";
				size = "1M";
				type = "EF02";
			};
            ESP = {
			  name = "ESP";
              size = "500M";
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
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
      disk1 = {
        type = "disk";
        # device = "/dev/sda";
        device = "/dev/vdb";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "storage";
              };
            };
          };
        };
      };
      disk2 = {
        type = "disk";
        # device = "/dev/sdb";
        device = "/dev/vdc";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "storage";
              };
            };
          };
        };
      };
    };
    zpool = {
      storage = {
        type = "zpool";
        mode = "mirror";
        mountpoint = "/storage";
		options = {
			ashift = "12";
			autoreplace = "on";
		};
		rootFsOptions = {
			xattr = "sa";
			compression = "lz4";
			atime = "off";
		};
        datasets = {
          nextcloud = {
            type = "zfs_fs";
            mountpoint = "/storage/nextcloud";
          };
		  jellyfin = {
            type = "zfs_fs";
            mountpoint = "/storage/jellyfin";
          };
        };
      };
    };
  };
}
