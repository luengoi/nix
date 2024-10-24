{ pkgs, lib, target, ... }:

{
  imports = [
    ../programs/firefox
    ../programs/kitty
    ../programs/tmux
    ../programs/zsh
  ];

  programs = {
    home-manager.enable = true;
  };

  home = {
    username = lib.mkDefault "${target.user.name}";
    homeDirectory = lib.mkDefault "${target.user.home}";
    stateVersion = lib.mkDefault "${target.home.stateVersion}";

    sessionVariables = {
      LANG = "en_US.UTF-8";
      EDITOR = "nvim";
      PAGER = "less";
      VISUAL = "nvim";
    };

    packages = with pkgs; [
      aria2
      bash
      bat
      cargo
      coreutils
      curl
      fd
      fzf
      gh
      git
      lsd
      ncurses
      neovim
      nodejs_22
      openssh
      python3
      ripgrep
      tmux
      tree-sitter
      zsh
    ];
  };
}
