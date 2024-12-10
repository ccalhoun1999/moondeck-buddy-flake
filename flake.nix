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
              fetchSubmodules = true;
              sha256 = "/cVEBpXVIdgKZ9yonwUDayii0T/X04PmLhTH/2S2cFc=";
            };

            nativeBuildInputs = [
              pkgs.cmake
              pkgs.qt6.wrapQtAppsHook
              pkgs.qt6.qtbase
              pkgs.procps
              pkgs.ninja
              pkgs.xorg.libXrandr
              # pkgs.libclang
              # pkgs.unixtools.procps
              # pkgs.ncurses5
            ];

            
            buildInputs = [
              pkgs.qt6.qtwebsockets
              pkgs.qt6.qthttpserver
              # pkgs.xorg.libX11
              # pkgs.xorg.libXext
              # pkgs.qt6.full
            ];

            # Explicitly set library paths if needed
            cmakeFlags = [
              # "-DPROCPS_LIBRARY=${pkgs.unixtools.procps}/lib"
              # "-DPROCPS_INCLUDE_DIR=${pkgs.unixtools.procps}/include"
              "-DPROCPS_LIBRARY=${pkgs.procps}/lib"
              "-DPROCPS_INCLUDE_DIR=${pkgs.procps}/include"
              # "-DENABLE_CLANG_TIDY=True"
              # "-DCMAKE_CXX_COMPILER=cl"
              # "-DCMAKE_BUILD_TYPE:STRING=Release"
              # "-B build"
              # "-G Ninja"
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
