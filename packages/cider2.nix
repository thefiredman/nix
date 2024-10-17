{ pkgs ? import <nixpkgs> { system = builtins.currentSystem; }
, appimageTools ? pkgs.appimageTools, lib ? pkgs.lib, fetchurl ? pkgs.fetchurl
}:

appimageTools.wrapType2 rec {
  pname = "cider";
  version = "2.5.3";

  src = fetchurl {
    url = "file://${./Cider.AppImage}";
    sha256 = "1f07c1c98f1abf502f23eb7bc2768d6e10cb5c1c60cd129888b1b584f52da3da";
  };

  extraInstallCommands = let
    contents = appimageTools.extract { inherit pname version src; };
    commandLineArgs =
      "--enable-features=UseOzonePlatform,VaapiVideoEncoder,VaapiVideoDecoder,VaapiIgnoreDriverChecks,VaapiVideoDecodeLinuxGL,CanvasOopRasterization,ParallelDownloading --ozone-platform-hint=auto --enable-smooth-scrolling";
  in ''
    mv $out/bin/${pname} $out/bin/${pname}-${version}

    install -m 444 -D ${contents}/${pname}.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}-${version} ${commandLineArgs}'
    cp -r ${contents}/usr/share/icons $out/share
  '';

  meta = with lib; {
    description =
      "A new look into listening and enjoying Apple Music in style and performance.";
    homepage = "https://cider.sh/";
    maintainers = [ maintainers.nicolaivds ];
    platforms = [ "x86_64-linux" ];
  };
}
