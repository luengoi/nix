#   nix.zsh
#   shortcuts and helpers around nix tools

export NIX_FLAKE_HOME="${NIX_FLAKE_HOME:-$XDG_CONFIG_HOME/nix}"

function dev() {
    [[ -z "${commands[nix]}" ]] && return 1
    local shell
    shell="${1:-}"
    if [ "$#" -gt 0 ]; then
        shift
    fi

    case "$shell" in
    rn|react-native)
        command nix develop "${NIX_FLAKE_HOME}#react-native" "$@" --command zsh
        ;;
    *)
        command nix develop "${NIX_FLAKE_HOME}#$shell" "$@" --command zsh
    esac
}

function dr() {
    [[ -z "${commands[darwin-rebuild]}" ]] && return 1
    local profile
    profile="${1:-}"
    if [ "$#" -gt 0 ]; then
        shift
    fi

    command darwin-rebuild switch --flake "${NIX_FLAKE_HOME}#$profile" "$@"
}
