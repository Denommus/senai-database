{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    pyproject-nix.url = "github:nix-community/pyproject.nix";
    pyproject-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      pyproject-nix,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        project = pyproject-nix.lib.project.loadPyproject {
          projectRoot = ./.;
        };

        python = pkgs.python3;

        shell =
          let
            arg = project.renderers.withPackages { inherit python; };
            pythonEnv = python.withPackages arg;
          in
          pkgs.mkShell {
            packages = [ pythonEnv ];
          };

        package =
          let
            attrs = project.renderers.buildPythonPackage { inherit python; };
          in
          python.pkgs.buildPythonPackage (attrs // { });
      in
      {
        devShells.default = shell;
        packages.default = package;
      }
    );
}
