#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MAC_DIR="$ROOT_DIR/macos"

chmod +x "$MAC_DIR/tools/make_icns.sh"
chmod +x "$MAC_DIR/launcher/build_macos.sh"
chmod +x "$MAC_DIR/editor/build_macos.sh"
chmod +x "$MAC_DIR/updater/build_macos.sh"
chmod +x "$MAC_DIR/installer/build_installer.sh"

if [ ! -f "$MAC_DIR/assets/storyweaver.icns" ]; then
  echo "Missing macos/assets/storyweaver.icns. Run:"
  echo "  $MAC_DIR/tools/make_icns.sh"
  exit 1
fi

"$MAC_DIR/launcher/build_macos.sh"
"$MAC_DIR/editor/build_macos.sh"
"$MAC_DIR/updater/build_macos.sh"
"$MAC_DIR/installer/build_installer.sh"

echo "Done. Output in macos/release"
