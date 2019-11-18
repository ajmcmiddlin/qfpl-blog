{ nixpkgs ? import ./nix/nixpkgs.nix
, compiler ? "ghc844"
}:
let
  inherit (nixpkgs) pkgs;

  reflex-tutorial = import ./reflex-tutorial { inherit nixpkgs; };
  growing-a-datepicker = import ./growing-a-datepicker { inherit nixpkgs; };

  # Import the nix package for our site generator
  generator = import ./generator { inherit nixpkgs compiler; };

  # Import the nix package for our generated site
  blog = import ./content {
    inherit generator reflex-tutorial growing-a-datepicker;
  };

  jobs = rec {
    inherit generator;
    inherit blog;
  };
in
  jobs
