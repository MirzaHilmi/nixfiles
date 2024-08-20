# Bootloader (GRUB) configuration
{pkgs, ...}: {
  boot.loader = {
    timeout = 10;
    efi = {canTouchEfiVariables = true;};
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      efiInstallAsRemovable = true;
      theme = pkgs.grubThemes.fallout;
    };
  };
}
