{ pkgs, inputs, ... }:
let
  userName = "mirza";
in {
  imports = [ (import ./tweaks.nix userName) ];

  users.extraUsers.${userName} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Mirza's Avatar";
    initialPassword = "password";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "docker"
    ];
  };

  home-manager = {
    nixosModules.home-manager { home-manager.sharedModules = [ inputs.zimfw.homeManagerModules.zimfw ] };
    users.${userName} = import ../../../../home-manager/${userName};
  };
}
