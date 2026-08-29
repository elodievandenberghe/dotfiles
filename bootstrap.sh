#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

nix-shell -p git stow nh emacs --run '
    echo "==> Stowing configuration..."
    stow -t "$HOME" configs

    echo "==> Installing Doom Emacs..."
    if [ ! -d "$HOME/.config/emacs" ]; then
        git clone --depth 1 \
            https://github.com/doomemacs/core \
            "$HOME/.config/emacs"
    fi

    "$HOME/.config/emacs/bin/doom" install

    echo "==> Applying NixOS configuration..."
    nh os switch ./nixos --extra-experimental-features nix-command
'

