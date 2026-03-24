{pkgs, ...}:
{
    users.users.im2sleepy = {
		shell = pkgs.zsh;
		ignoreShellProgramCheck = true;
        isNormalUser = true;
        initialPassword = "123";
        extraGroups = [ "wheel" "libvirtd" "audio" "networkmanager" "dialout" "usb" "docker" "plugdev"];
        packages = with pkgs; [
			sof-firmware
			lldb
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
