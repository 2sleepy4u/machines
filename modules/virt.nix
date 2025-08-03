{ ... }:
{
	programs.virt-manager.enable = true;

	users.groups.libvirtd.members = ["im2sleepy"];

	virtualisation.libvirtd.enable = true;

	virtualisation.spiceUSBRedirection.enable = true;
}
