{ pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.systemd.enable = true;
    resumeDevice = "/dev/disk/by-label/swap";

    kernelPackages = pkgs.linuxPackages_6_9;
  };
}
