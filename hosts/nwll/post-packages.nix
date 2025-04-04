{ pkgs, stable, inputs, ... }: {
  # less important packages
  # I plan on having this step be ignored while installing the system
  environment = {
    systemPackages = with pkgs; [
      # requires manual, hard to reproduce steps
      # inputs.affinity-nix.packages.${pkgs.system}.designer
      (writeShellScriptBin "davinci-resolve" ''
        QT_QPA_PLATFORM=xcb ${stable.davinci-resolve}/bin/davinci-resolve
      '')

      # games
      retroarch
      libretro.mupen64plus
      mangohud
      torzu_git
      ryujinx
      prismlauncher
      airshipper
      modrinth-app
    ];
  };
}
