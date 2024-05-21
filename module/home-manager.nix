{pkgs, ...}: {
  # add home-manager user settings here
  home.packages = with pkgs; [
    git 
    neovim
    fish
    gcc
    gnumake
    fzf
    gcc
    nodejs
    tmux
    alacritty
    d2coding
    nerdfonts
    stow
    k9s
    kubectl
  ];

  programs.git = {
    enable = true;
    userName = "aryuuu";
    userEmail = "herppratama@gmail.com";

    signing = {
      signByDefault = true;
      key = "";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {};

    xwayland.enable = true;
  }

  # xsession.windowManager.i3 = {
  #   enable = true;
  #   settings = {};

  #   xwayland.enable = true;
  # }

  home.stateVersion = "23.11";
}
