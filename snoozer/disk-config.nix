{ lib, ... }:
{
  disko.devices = {
    disk = {
      nixos = {
        type = "disk";
        device = "/dev/nvme0n1";
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
        device = "/dev/sda";
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
        device = "/dev/sdb";
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
		rootFsOotions = {
			ashift = 12;
			xattr = "sa";
			compression = "lz4";
			atime = "off";
		};

        datasets = {
          dataset = {
            type = "zfs_fs";
            mountpoint = "/storage/dataset";
          };
        };
      };
    };
  };
}
