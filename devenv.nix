{
  pkgs,
  ...
}:
{
  imports = [
    ./devenv/modules/python.nix
  ];

  languages.python.pyprojectOverrides =
    final: prev:
    let
      packagesToBuildWithSetuptools = [
        "robotframework"
      ];
    in
    {
      "calver" = prev."calver".overrideAttrs (old: {
        postPatch = ''
          substituteInPlace pyproject.toml \
            --replace-fail 'license = "Apache-2.0"' 'license = {text = "Apache-2.0"}'
        '';
      });
      "hatchling" = prev."hatchling".overrideAttrs (old: {
        propagatedBuildInputs = [ final."editables" ];
      });
    }
    // builtins.listToAttrs (
      map (pkg: {
        name = pkg;
        value = prev.${pkg}.overrideAttrs (old: {
          nativeBuildInputs =
            old.nativeBuildInputs
            ++ final.resolveBuildSystem ({
              "setuptools" = [ ];
            });
        });
      }) packagesToBuildWithSetuptools
    );

  packages = [
    pkgs.gnumake
    pkgs.gnused
  ];

  dotenv.disableHint = true;

  enterShell = ''
    unset PYTHONPATH
    export UV_NO_SYNC=1
    export UV_PYTHON_PREFERENCE=system
    export UV_PYTHON_DOWNLOADS=never
    export REPO_ROOT=$(git rev-parse --show-toplevel)
  '';

  enterTest = ''
    make test
  '';

  cachix.pull = [ "datakurre" ];

  git-hooks.hooks.treefmt = {
    enable = true;
    settings.formatters = [
      pkgs.nixfmt-rfc-style
    ];
  };
}
