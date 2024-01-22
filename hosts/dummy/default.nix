# Host-level configuration
# (it replaces /etc/nixos/configuration.nix)
{ config, pkgs, ... }:

{
  imports = [
    # inputs.hardware.nixosModules.lenovo-legion-15arh05h
    
    ./hardware-configuration.nix
    ../common/global
    ../common/extras/gnome-wayland.nix
    ../common/extras/pipewire.nix
    ../common/extras/docker.nix
    ../common/users/mirza
  ];

  networking = {
    hostName = "dummy";
    networkmanager.enable = true;
  };

  services.openssh.enable = true;

  nixpkgs = {
    config.allowUnfree = true;
  };
}