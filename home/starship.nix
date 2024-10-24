{ ... }:

{
  imports = [
    ./darwin/default.nix
  ];

  programs = {
    zsh = {
      initExtra = ''
        if [[ $(uname -m) == "arm64" ]]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        
        # -- INTEGRATIONS -----------------------------------------------------
        # ---------------------------------------------------------------------

        ${builtins.readFile ./programs/zsh/integrations/fzf.zsh}
      '';
    };
  };
}
