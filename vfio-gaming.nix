{ lib, config, pkgs, ... }:
with lib;
let
    cfg = config.services.vfio-gaming;
in {
    options.services.vfio-gaming = {
        enable = mkEnableOption "vfio gaming service";
        gpuIDs = mkOption {
            type = types.listOf types.string;
            default = [];
        };
    };

    config = mkIf cfg.enable {
        virtualisation.libvirtd.enable = true;
        virtualisation.libvirtd.qemu.ovmf.enable = true;
        programs.dconf.enable = true;
        hardware.opengl.enable = true;
        virtualisation.spiceUSBRedirection.enable = true;

        environment.systemPackages = with pkgs; [ 
            looking-glass-client
            virt-manager
            qemu
            qemu_kvm
            libvirt
            barrier
           
            linuxKernel.packages.linux_6_1.vendor-reset 
        ];

        #boot.extraModprobeConfig = "options pci.stub.ids=" + lib.concatStringsSep "," cfg.gpuIDs;
        boot.extraModprobeConfig = "options kvm_intel nested=1";
        boot.extraModulePackages = [ config.boot.kernelPackages.vendor-reset ];
        #boot.blacklistedKernelModules = [ "amdgpu" "radeon" ];
        boot.kernelPatches = [{
                name = "vendor-reset";
                patch = null;
                extraConfig = ''
                    FTRACE y
                    KPROBES y
                    PCI_QUIRKS y
                    KALLSYMS y
                    KALLSYMS_ALL y
                    FUNCTION_TRACER y
                '';
            }];
        boot.initrd.kernelModules = [ 
            "kvm_intel"
            "vendor-reset"
            "vfio_pci"
            "vfio"
            "vfio_iommu_type1"
            "vfio_virqfd"
        ];
        boot.kernelParams = [
            "intel_iommu=on"
            "iommu=pt" 
            "initcall_blacklist=sysfg_init"
            ("vfio-pci.ids=" + lib.concatStringsSep "," cfg.gpuIDs)
            #"rd.driver.pre=vfio-pci"
        ]; 
            # isolate GPU
    };
}
