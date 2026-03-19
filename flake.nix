{
  description = "My personal NUR repository";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    git-hooks.url = "github:cachix/git-hooks.nix";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      flake-parts,
      git-hooks,
      nixpkgs,
      treefmt-nix,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [
        treefmt-nix.flakeModule
        git-hooks.flakeModule
      ];

      perSystem =
        { config, pkgs, ... }:
        let
          nurAttrs = import ./default.nix { inherit pkgs; };
        in
        {
          packages = pkgs.lib.filterAttrs (_: v: pkgs.lib.isDerivation v) nurAttrs;

          treefmt = {
            projectRootFile = "flake.nix";
            programs.nixfmt.enable = true;
            programs.prettier.enable = true;
          };

          formatter = config.treefmt.build.wrapper;

          pre-commit = {
            check.enable = true;
            settings.hooks.treefmt = {
              enable = true;
              package = config.treefmt.build.wrapper;
            };
            settings.hooks.convco = {
              enable = true;
              stages = [ "commit-msg" ];
            };
          };

          devShells.default = pkgs.mkShell {
            inputsFrom = [ config.pre-commit.devShell ];
            packages = [ config.treefmt.build.wrapper ];
          };
        };

      flake.legacyPackages = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
        system:
        import ./default.nix {
          pkgs = import nixpkgs { inherit system; };
        }
      );
    };
}
