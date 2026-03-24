# Add this to your configuration.nix
{ config, pkgs, ... }:

{
  # Enable snapper
  services.snapper = {
    configs = {
      home = {
        SUBVOLUME = "/home";
        ALLOW_USERS = [ "your-username" ]; # Replace with your username
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        
        # Snapshot schedule
        TIMELINE_MIN_AGE = "1800"; # Minimum 30 minutes between snapshots
        TIMELINE_LIMIT_HOURLY = "0"; # Don't keep hourly
        TIMELINE_LIMIT_DAILY = "3"; # Keep last 3 daily snapshots
        TIMELINE_LIMIT_WEEKLY = "0"; # Don't keep weekly (we'll send to server)
        TIMELINE_LIMIT_MONTHLY = "0"; # Don't keep monthly
        TIMELINE_LIMIT_YEARLY = "0"; # Don't keep yearly
      };
    };
    
    # Run snapper timeline every day at boot/daily
    snapshotInterval = "daily";
  };

  # Optional: Create snapshot on boot
  systemd.services.snapper-boot-snapshot = {
    description = "Create snapper snapshot on boot";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.snapper}/bin/snapper -c home create --description 'boot-snapshot'";
    };
  };

  # Install snapper and btrfs-progs
  environment.systemPackages = with pkgs; [
    snapper
    btrfs-progs
  ];
}
