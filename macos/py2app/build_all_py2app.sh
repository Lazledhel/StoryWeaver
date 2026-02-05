#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
MAC_DIR="$ROOT_DIR/macos"
PY2_DIR="$MAC_DIR/py2app"

if [ ! -f "$MAC_DIR/assets/storyweaver.icns" ]; then
  echo "Missing macos/assets/storyweaver.icns. Run:"
  echo "  $MAC_DIR/tools/make_icns.sh"
  exit 1
fi

python3 "$PY2_DIR/setup_launcher.py" py2app
rm -rf "$ROOT_DIR/macos/release/StoryWeaverLauncher.app"
if [ -d "$ROOT_DIR/dist/launcher.app" ]; then
  cp -R "$ROOT_DIR/dist/launcher.app" "$ROOT_DIR/macos/release/StoryWeaverLauncher.app"
fi

python3 "$PY2_DIR/setup_editor.py" py2app
rm -rf "$ROOT_DIR/macos/release/StoryWeaverEditor.app"
if [ -d "$ROOT_DIR/dist/editor.app" ]; then
  cp -R "$ROOT_DIR/dist/editor.app" "$ROOT_DIR/macos/release/StoryWeaverEditor.app"
fi

python3 "$PY2_DIR/setup_updater.py" py2app
rm -rf "$ROOT_DIR/macos/release/StoryWeaverUpdater.app"
if [ -d "$ROOT_DIR/dist/updater.app" ]; then
  cp -R "$ROOT_DIR/dist/updater.app" "$ROOT_DIR/macos/release/StoryWeaverUpdater.app"
fi

python3 "$PY2_DIR/setup_installer.py" py2app
rm -rf "$ROOT_DIR/macos/release/StoryWeaverInstaller.app"
if [ -d "$ROOT_DIR/dist/installer.app" ]; then
  cp -R "$ROOT_DIR/dist/installer.app" "$ROOT_DIR/macos/release/StoryWeaverInstaller.app"
fi

echo "Done. Output in macos/release"
