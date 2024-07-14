{
  flake.homeModules = {
    paths = import ./paths.nix;
    kitty = import ./kitty;
    dev = import ./dev;
    git = import ./git;
    tmux = import ./tmux;
    fzf = import ./fzf;
    fd = import ./fd;
    fish = import ./fish;
    bash = import ./bash;
    lsd = import ./lsd;
    scripts = import ./scripts;
  };
}
