{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    plugins = builtins.attrValues {
      inherit
        (pkgs.obs-studio-plugins)
        wlrobs
        input-overlay
        obs-backgroundremoval
        obs-pipewire-audio-capture
        ;
    };
  };
}
