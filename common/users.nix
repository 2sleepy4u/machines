{pkgs}:
{
    users.users.im2sleepy = {
        isNormalUser = true;
        initialPassword = "123";
        extraGroups = [ "wheel" "libvirtd" "audio" "networkmanager" "dialout" "usb" "docker"];
        packages = with pkgs; [
			sof-firmware
			lldb
            cargo
            gh
			gcc
			pciutils
			tree
			#pgadmin4
			ripgrep
			tree
			usbutils
			#iOS
            usbmuxd
            libusbmuxd
            libimobiledevice
            ifuse


        ];
    };


}
