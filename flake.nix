{
  description = "HX CV dev-shell";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      treefmt-nix,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
      in
      {
        formatter = treefmtEval.config.build.wrapper;

        checks = {
          formatting = treefmtEval.config.build.check self;
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            go-task
            sops
            age
            (texlive.combine {
              inherit (texlive)
                scheme-small
                xetex
                fontspec
                unicode-math
                enumitem
                ragged2e
                geometry
                fancyhdr
                xcolor
                xifthen
                ifmtarg
                etoolbox
                setspace
                parskip
                tcolorbox
                hyperref;
            })
            python3
            python313Packages.pyyaml
            python313Packages.pydantic
            python313Packages.email-validator
            python313Packages.jinja2
            python313Packages.typer
          ];
        };
      }
    );
}
