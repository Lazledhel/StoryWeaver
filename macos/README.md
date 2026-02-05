# StoryWeaver macOS Build

This folder contains scripts to build macOS `.app` bundles for:
- Launcher
- Editor
- Updater
- Installer

These scripts must be run on macOS. Building `.app` bundles is not possible on Windows.

## Prerequisites (macOS)
- Python 3.11+
- PyInstaller (`python3 -m pip install pyinstaller`)
- Dependencies used by the app (PySide6, cryptography, docx, reportlab, etc.)

## Icon
macOS needs an `.icns` icon. Put a PNG at:
`macos/assets/storyweaver.png`

Then run:
```
./macos/tools/make_icns.sh
```

This will create:
`macos/assets/storyweaver.icns`

## Build All
```
./macos/build_all.sh
```

Outputs are placed in:
`macos/release/`

## DMG (Optional)
To create a `.dmg` (classic macOS installer image), run:
```
./macos/installer/build_dmg.sh
```

This produces:
`macos/release/StoryWeaver.dmg`

## Notes
- The installer `.app` is a small GUI that copies the apps into `/Applications/StoryWeaver`.
