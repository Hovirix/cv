{ pkgs, ... }:

{
  projectRootFile = "flake.nix";

  programs = {
    nixfmt.enable = true;
    yamlfmt = {
      enable = true;
      settings = {
        formatter = {
          type = "basic";
          retain_line_breaks_single = true;
        };
      };
    };
    ruff-check.enable = true;
    ruff-format.enable = true;
    latexindent.enable = true;
  };
}
