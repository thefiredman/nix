{ config, ... }: {
  home-manager.users.${config.h.username} = {
    programs.fd = {
      enable = true;
      ignores = [
        ".local"
        ".m2"
        ".cache"
        "Movies"
        "Music"
        "Public"
        "Pictures"
        "Desktop"
        "Library"
        "Downloads"
        "Applications"
        "Documents"
        ".git"
        ".github"
        ".cups"
        ".vscode"
        ".DS_Store"
        ".Trash"
        ".ssh"
        "target"
        ".git/"
        "target/"
      ];
    };
  };
}
