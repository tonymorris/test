{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:
let
  inherit (nixpkgs) pkgs;
  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  sources = {
    tasty-hedgehog = pkgs.callPackage (pkgs.fetchFromGitHub {
      owner = "qfpl";
      repo = "tasty-hedgehog";
      rev = "5da389f5534943b430300a213c5ffb5d0e13459e";
      sha256 = "04pmr9q70gakd327sywpxr7qp8jnl3b0y2sqxxxcj6zj2q45q38m";
    }) {};

    natural = pkgs.callPackage (pkgs.fetchFromGitHub {
      owner = "qfpl";
      repo = "natural";
      rev = "1baa715d32d85be2a2da1ae087ad0349559a9c3e";
      sha256 = "0qq3b0hwpmwvbvjnqm59mqsh6aa4pvcirrq7qsdanwh2d5bd9fma";
    }) {};
  };

  modifiedHaskellPackages = haskellPackages.override {
    overrides = self: super: {
      tasty-hedgehog = import sources.tasty-hedgehog { inherit nixpkgs compiler; };
      natural = import sources.natural { inherit nixpkgs compiler; };
    };
  };

  test = modifiedHaskellPackages.callPackage ./test.nix {};
in
  test
