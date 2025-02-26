{pkgs, ...}: {
  imports = [./shared];

  home = {
    username = "mirza";
    homeDirectory = "/home/mirza";
    packages = with pkgs; [
      bccli
      chafa
      dig
      discord
      distrobox
      easyeffects
      eduvpn-client
      fd
      ffmpeg-headless
      gnumake
      gthumb
      hurl
      jetbrains.idea-community
      libreoffice
      monaspace
      nmap
      nvtopPackages.full
      obsidian
      parabolic
      postman
      powertop
      simple-http-server
      slack
      tcpdump
      tio
      ungoogled-chromium
      unstable.zed-editor
      unzip
      wl-clip-persist
      wl-clipboard
      zap
      zen-browser
      zoom-us
    ];
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
    };

    stateVersion = "23.11";
  };

  programs = {
    vscode.enable = true;
    fastfetch.enable = true;
    jq.enable = true;
    k9s.enable = true;
    ripgrep.enable = true;
  };
  custom.programs = {
    bat.enable = true;
    btop.enable = true;
    direnv.enable = true;
    fzf.enable = true;
    ghostty.enable = true;
    git.enable = true;
    gpg.enable = true;
    gtk.enable = true;
    kind.enable = true;
    lazygit.enable = true;
    lsd.enable = true;
    obs.enable = true;
    ohmyposh.enable = true;
    spicetify.enable = true;
    ssh.enable = true;
    tldr.enable = true;
    tmux.enable = true;
    zsh.enable = true;
  };

  xdg.userDirs = {
    publicShare = null;
    templates = null;
  };
}
