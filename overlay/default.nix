{inputs, ...}: {
  # This one brings custom packages from the 'pkgs' directory
  extra = final: prev: import ../pkg {pkgs = final;};

  # Unstable nixpkgs set (declared in the flake inputs) are
  # accessible through 'pkgs.unstable'
  unstable-package = final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config = {
        allowUnfree = true;
      };
    };
  };
}
