{ lib, ... }:
let 
	nixosDisk = "/dev/vda";
	dataDisk = "/dev/vdb";
	backupDisk = "/dev/vdc";
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
		# mode = {
		#         topology = {
		#           type = "topology";
		#           vdev = [{
		#             mode = "mirror";
		#             members = ["vdb" "vdc"];
		#           }];
		#         };
		#       };
        mode = "mirror";
		options = {
			ashift = "12";
			autoreplace = "on";
			# mountpoint = "/mnt/storage";
		};
		rootFsOptions = {
			canmount = "on";
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
        };
      };
    };
  };
}
