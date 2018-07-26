{ mkDerivation, base, checkers, hedgehog, lens, natural, QuickCheck
, stdenv, tasty, tasty-hedgehog, tasty-hunit, tasty-quickcheck
, transformers
}:
mkDerivation {
  pname = "test";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [ base lens natural ];
  testHaskellDepends = [
    base checkers hedgehog lens QuickCheck tasty tasty-hedgehog
    tasty-hunit tasty-quickcheck transformers
  ];
  description = "Test";
  license = stdenv.lib.licenses.bsd3;
}
