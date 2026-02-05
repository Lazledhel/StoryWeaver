#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
MAC_DIR="$ROOT_DIR/macos"
OUT_DIR="$MAC_DIR/release"

ICON="$MAC_DIR/assets/storyweaver.icns"
if [ ! -f "$ICON" ]; then
  echo "Missing icon: $ICON"
  exit 1
fi

python3 -m PyInstaller \
  --noconfirm --clean --windowed \
  --name "StoryWeaverEditor" \
  --icon "$ICON" \
  --add-data "$ROOT_DIR/Editor/DejaVuSans.ttf:." \
  --add-data "$ROOT_DIR/storyweaver.ico:." \
  --hidden-import docx \
  --hidden-import _socket \
  "$ROOT_DIR/Editor/editor.py"

mkdir -p "$OUT_DIR"
rm -rf "$OUT_DIR/StoryWeaverEditor.app"
cp -R "$ROOT_DIR/dist/StoryWeaverEditor.app" "$OUT_DIR/StoryWeaverEditor.app"

echo "Editor app -> $OUT_DIR/StoryWeaverEditor.app"
