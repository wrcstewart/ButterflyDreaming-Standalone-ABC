#!/bin/sh
# Refresh the vendored module from the ButterflyDreaming working tree.
#
# Vendoring is deliberate — a developer should be able to open the module, read
# it and break it without a server — but the cost is DRIFT, and this project has
# paid it before: two copies of an earlier module diverged and polish landed in
# only one of them. So the copy is refreshed by one deliberate command, and the
# commit it came from is written down.
#
# COPY-DOWN, NOT A MERGE. Local changes to music_module.html are discarded.
set -e
BD="${BD_REPO:-$HOME/butterflydreaming_graphviewer1}"
SRC="$BD/M_Music/music_module.html"

[ -f "$SRC" ] || { echo "no module at $SRC — set BD_REPO to your BD checkout" >&2; exit 1; }

cp "$SRC" ./music_module.html
{
  echo "music_module.html was copied from ButterflyDreaming:"
  echo "  source : M_Music/music_module.html"
  echo "  commit : $(git -C "$BD" rev-parse --short HEAD 2>/dev/null || echo unknown)"
  echo "  dated  : $(git -C "$BD" log -1 --format=%cd --date=short 2>/dev/null || echo unknown)"
  echo "  taken  : $(date -u +%Y-%m-%dT%H:%MZ)"
  echo
  echo "Refresh with ./sync_from_bd.sh — a copy-down, not a merge."
} > MODULE_SOURCE.txt

echo "module refreshed:"
sed 's/^/  /' MODULE_SOURCE.txt
