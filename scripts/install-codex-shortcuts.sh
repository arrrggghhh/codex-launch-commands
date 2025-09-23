#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SRC_DIR="$REPO_ROOT/bin"
DEST_DIR="${HOME}/.local/bin"
CMDS=(cdxh cdxm cdxl cdxmm cdxxh cdxxm cdxxl)
mkdir -p "$DEST_DIR"
for cmd in "${CMDS[@]}"; do
  if [[ ! -f "$SRC_DIR/$cmd" ]]; then
    echo "Warning: missing source $SRC_DIR/$cmd" >&2
    continue
  fi
  ln -sf "$SRC_DIR/$cmd" "$DEST_DIR/$cmd"
done
echo "Symlinks created in $DEST_DIR:"
for cmd in "${CMDS[@]}"; do
  if [[ -L "$DEST_DIR/$cmd" ]]; then
    target="$(readlink -f "$DEST_DIR/$cmd" || readlink "$DEST_DIR/$cmd")"
    echo " - $DEST_DIR/$cmd -> $target"
  fi
done
case ":$PATH:" in
  *":$DEST_DIR:"*) IN_PATH=1 ;;
  *) IN_PATH=0 ;;
esac
if [[ $IN_PATH -eq 0 ]]; then
  echo
  echo "Note: add to PATH -> export PATH=\"$DEST_DIR:\$PATH\""
fi

