{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    defaultOptions = ["--layout=reverse --inline-info --height=90%"];
  };
}
