# Host-level configuration
# (it replaces /etc/nixos/configuration.nix)
{inputs, ...}: {
  imports = [
    inputs.hardware.nixosModules.lenovo-legion-15arh05h
    inputs.disko.nixosModules.disko

    (import ./disko.nix {device = "/dev/sda";})
    ./hardware-configuration.nix

    ../common
    ../common/de/gnome

    ../common/user/mirza.nix

    ../../module/nixos/nixvim
    ../../module/nixos/sops.nix

    ../common/extra/docker.nix
    ../common/extra/gns3.nix
    ../common/extra/nh.nix
    ../common/extra/pipewire.nix
    ../common/extra/v4l2loopback.nix
    ../common/extra/virt-manager.nix
    ../common/extra/zsh.nix

    ../../module/nixos/ssh.nix
  ];

  networking = {
    hostName = "nixsina";
    networkmanager = {
      enable = true;
      enableStrongSwan = true;
    };
  };

  services.xl2tpd.enable = true;
  services.strongswan = {
    enable = true;
    secrets = ["ipsec.d/ipsec.nm-l2tp.secrets"];
  };
}
