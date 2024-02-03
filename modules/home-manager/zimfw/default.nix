{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.zsh;

  relativeToDotDir = file:
    (optionalString (cfg.dotDir != null)
      (cfg.dotDir + "/"))
    + file;

  zimfwModule = types.submodule {
    options = {
      enable = mkEnableOption "Zim - ${pkgs.zimfw.meta.description}";

      homeDir = mkOption {
        type = types.str;
        default = "$XDG_CACHE_HOME/zim";
        example = "$HOME/.zim";
        description = ''
          Directory where the zim init.zsh, plugins directory and more should be located,
          relative to the users home directory. The default is the $XDG_CACHE_HOME/zim.
        '';
      };

      degit = mkOption {
        type = types.bool;
        default = true;
        example = false;
        description = ''
          Use zim's degit tool for faster module installation.
        '';
      };

      versionCheck = mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = "Check if zimfw has a new version available every 30 days";
      };

      modules = mkOption {
        type = types.listOf types.str;
        default = [];
        example = [
          "completion"
          "utility"
          "romkatv/powerlevel10k"
          "zsh-users/zsh-syntax-highlighting"
        ];
        description = ''
          List of modules. These are added to `.zimrc` verbatim,
          so ENV vars will work for paths to local modules.
          See https://github.com/zimfw/zimfw?tab=readme-ov-file#zmodule
        '';
      };
    };
  };
in {
  meta.maintainers = [maintainers.mirzahilmi];

  options = {
    programs.zsh = {
      zimfw = mkOption {
        type = zimfwModule;
        default = {};
        description = "Options to configure zimfw.";
      };
    };
  };

  config = mkIf cfg.zimfw.enable {
    home.packages = with pkgs; [zimfw];

    programs.zsh.localVariables = {
      ZIM_HOME = cfg.zimfw.homeDir;
      ZIM_CONFIG_FILE = "${relativeToDotDir ".zimrc"}";
    };

    programs.zsh.initExtra = ''
      ## Generated by Nix ##
      ${optionalString (cfg.zimfw.degit) ''
        zstyle ':zim:zmodule' use 'degit'
      ''}
      ${optionalString (cfg.zimfw.disableVersionCheck) ''
        zstyle ':zim' disable-version-check yes
      ''}

      # Ensure zimfw is installed before attempting to load.
      if [[ -e ${pkgs.zimfw}/zimfw.zsh ]]; then
        if [[ ! -e $ZIM_HOME ]]; then
          mkdir -p $ZIM_HOME
        fi

        # Install missing modules, and update $ZIM_HOME/init.zsh
        # if missing or outdated.
        if [[ ! $ZIM_HOME/init.zsh -nt $ZIM_CONFIG_FILE ]]; then
          source ${pkgs.zimfw}/zimfw.zsh init -q
        fi

        # Initialize modules.
        source $ZIM_HOME/init.zsh
      fi
      ######################
    '';

    home.file."${relativeToDotDir ".zimrc"}".text =
      concatStringsSep "\n"
      (map (module: "zmodule ${module}") cfg.zimfw.modules);
  };
}
