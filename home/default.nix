{
  flake.homeModules = {
    paths = import ./paths.nix;
    kitty = import ./kitty;
    alacritty = import ./alacritty;
    wezterm = import ./wezterm;
    foot = import ./foot;
    dev = import ./dev;
    git = import ./git;
    tmux = import ./tmux;
    fzf = import ./fzf;
    fd = import ./fd;
    fish = import ./fish;
    bash = import ./bash;
    lsd = import ./lsd;
    river = import ./river;
    fuzzel = import ./fuzzel;
    chromium = import ./chromium;
    xdg = import ./xdg;
    scripts = import ./scripts;
    nixCats = import ./nixCats;
  };
}
