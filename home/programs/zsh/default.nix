{
  pkgs,
  config,
  lib,
  ...
}:

{
  programs.zsh = {
    enable = true;
    package = pkgs.zsh;
    enableCompletion = true;
    dotDir = ".config/zsh";
    defaultKeymap = "viins";

    history = {
      path = "${config.xdg.stateHome}/zsh/.zsh_history";
      size = 10000;
      save = 10000;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = false;
      ignorePatterns = [
        "l"
        "la"
        "ll"
        "clear"
      ];
    };

    sessionVariables = {
      TERM = "xterm-256color";
    };

    shellAliases = {
      ls = "lsd --color=auto --group-dirs=first";
      ll = "ls -lh";
      la = "ls -lAh";
      lsa = "ls -lah";
      "..." = "../..";
      "...." = "../../..";
      "....." = "../../../..";
      "......" = "../../../../..";
    };

    initExtraFirst = ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';

    initExtra = ''
      setopt interactivecomments
      setopt magicequalsubst
      setopt notify
      setopt numericglobsort
      setopt append_history
      setopt extended_history
      setopt hist_expire_dups_first
      setopt hist_ignore_dups
      setopt hist_ignore_space
      setopt hist_verify
      setopt inc_append_history
      setopt share_history
      setopt nobeep
      setopt auto_pushd
      setopt pushd_ignore_dups
      setopt pushd_minus
      setopt pushd_silent

      ${builtins.readFile ./keybindings.zsh}
    '';

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "prompts";
        src = lib.cleanSource ./prompts;
        file = "rainbow.zsh";
      }
    ];
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];
}
