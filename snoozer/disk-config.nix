{ lib, ... }:
let 
	nixosDisk = "/dev/nvme0n1";
	dataDisk = "/dev/sda";
	backupDisk = "/dev/sdb";
in
{
  disko.devices = {
    disk = {
      nixos = {
        type = "disk";
		device = nixosDisk;
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
        device = dataDisk;
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
        device = backupDisk;
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
		#proviamo
		mountpoint = "/mnt/storage";
		options = {
			ashift = "12";
			autoreplace = "on";
		};
		rootFsOptions = {
			canmount = "off";
			xattr = "sa";
			compression = "lz4";
			atime = "off";
		};
        datasets = {
          nextcloud = {
            type = "zfs_fs";
            options = {
				compression = "lz4";
				canmount = "on";
				mountpoint = "/mnt/storage/nextcloud";
			};
          };
		  jellyfin = {
            type = "zfs_fs";
			options = {
				compression = "lz4";
				canmount = "on";
				mountpoint = "/mnt/storage/jellyfin";
			};
          };
		  caddy = {
            type = "zfs_fs";
			options = {
				compression = "lz4";
				canmount = "on";
				mountpoint = "/mnt/storage/caddy";
			};
          };
		  mail = {
            type = "zfs_fs";
			options = {
				compression = "lz4";
				canmount = "on";
				mountpoint = "/mnt/storage/mail";
			};
          };
        };
      };
    };
  };
}
