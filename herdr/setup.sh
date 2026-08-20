#!/usr/bin/env bash

set -euo pipefail

if ! command -v herdr >/dev/null 2>&1; then
    curl -fsSL https://herdr.dev/install.sh | sh
fi

herdr integration install claude
herdr integration install codex
herdr plugin install paulbkim-dev/vim-herdr-navigation --yes
