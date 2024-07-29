{
  flake.homeModules = {
    paths = import ./paths.nix;
    kitty = import ./kitty;
    foot = import ./foot;
    alacritty = import ./alacritty;
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
    scripts = import ./scripts;
  };
}
