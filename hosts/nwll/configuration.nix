{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vesktop
    qbittorrent
  ];

  security.sudo.wheelNeedsPassword = false;
  users.users.dashalev = {
    shell = pkgs.fish;
    uid = 1000;
  };

  fonts = {
    packages = with pkgs;
      [ (nerdfonts.override { fonts = [ "CascadiaCode" ]; }) ];
  };
}
