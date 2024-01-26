{ pkgs, inputs, ... }:
{
  imports = [
    ../programs/gnome-tweaks
    ../programs/vscode
    
    ../programs/cli/git.nix
    ../programs/cli/gpg.nix
    ../programs/cli/go.nix
    ../programs/cli/neovim.nix
    ../programs/cli/home-manager.nix
    ../programs/cli/zsh
  ];

  home = {
    username = "mirza";
    homeDirectory = "/home/mirza";
  };

  dconf.enable = true;

  nixpkgs.config.allowUnfreePredicate = _: true;

  home.packages = with pkgs; [
    bat
    btop
    cool-retro-term
    floorp
    libreoffice
    lsd
    (vesktop.overrideAttrs (prev: {
      desktopItems = [ ((builtins.elemAt prev.desktopItems 0).override (_: {
        icon = "${../../assets/discord.svg}";
        desktopName = "Discord";
      })) ];
    }))
    wl-clipboard
  ];

  home.stateVersion = "23.11";
}