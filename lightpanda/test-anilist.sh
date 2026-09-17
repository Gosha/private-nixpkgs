#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

if [[ ! -x ./result/bin/lightpanda ]]; then
  nix-build >&2
fi

exec ./result/bin/lightpanda fetch https://anilist.co/ \
  --load-resources worker \
  --wait-script 'document.querySelector(".trending .media-card a.title") && !document.querySelector(".trending .cover.loading")' \
  --wait-ms 20000 \
  --dump markdown \
  --dump-selector '.landing-section.trending' \
  --strip-mode ui
