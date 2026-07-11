_: {
  flake.nixosModules.host-laptop-hardware =
    {
      config,
      lib,
      modulesPath,
      ...
    }:

    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];
      boot = {
        initrd.availableKernelModules = [
          "xhci_pci"
          "ahci"
          "nvme"
          "uas"
          "sd_mod"
          "rtsx_pci_sdmmc"
        ];
        initrd.kernelModules = [ ];
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
      };

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/bdca751e-4528-48bc-9eaf-6ae432ca1ee2";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/953F-00B8";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      swapDevices = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
