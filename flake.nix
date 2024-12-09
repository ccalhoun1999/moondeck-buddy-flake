{
  description = "moondeck-buddy";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = rec {
          default = moondeck-buddy;
          moondeck-buddy = pkgs.multiStdenv.mkDerivation {
            pname = "moondeck-buddy";
            version = "main";

            src = pkgs.fetchFromGitHub {
              owner = "FrogTheFrog";
              repo = "moondeck-buddy";
              rev = "main";
              sha256 = "/cVEBpXVIdgKZ9yonwUDayii0T/X04PmLhTH/2S2cFc=";
            };

            nativeBuildInputs = [
              pkgs.cmake
              pkgs.qt6.full
              pkgs.xorg.libX11
              pkgs.xorg.libXrandr
              pkgs.xorg.libXext
              # pkgs.procps
              pkgs.procs
              # pkgs.unixtools.procps
              # pkgs.ncurses5
            ];

            # Explicitly set library paths if needed
            cmakeFlags = [
              "-DPROCPS_LIBRARY=${pkgs.procps}/lib"
              "-DPROCPS_INCLUDE_DIR=${pkgs.procps}/include"
            ];

            # installPhase = ''
            #   # cd bin
            #   # ls
            #   runHook preInstall
            #   mkdir -p $out/bin
            #   cp bin/* $out/bin
            #   runHook postInstall
            # '';
          };
        };
      }
    );
}
