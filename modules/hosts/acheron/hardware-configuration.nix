
{ self, inputs, ... }: {

	flake.nixosModules.acheronHardware = { config, lib, pkgs, modulesPath, ... }:
	{
        # Whatever results from `nixos-generate-config` goes here, but in a way that it can be easily merged with the configuration.nix file.
        imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/81a327e9-aa1d-460d-a43f-537342e075d5";
      fsType = "btrfs";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/81a327e9-aa1d-460d-a43f-537342e075d5";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/81a327e9-aa1d-460d-a43f-537342e075d5";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7767-4671";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/9fce7b80-3cd0-4b99-9007-5817bb5341bc"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

	};
}
