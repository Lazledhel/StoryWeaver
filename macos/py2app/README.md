# StoryWeaver macOS (py2app)

This folder contains py2app build scripts for:
- Launcher
- Editor
- Updater
- Installer

Run on macOS only.

## 1) Create icon (.icns)
Place a 1024x1024 PNG at:
`macos/assets/storyweaver.png`

Then run:
```
./macos/tools/make_icns.sh
```

## 2) Install deps (macOS)
```
python3 -m pip install --upgrade pip
python3 -m pip install py2app PySide6 cryptography python-docx reportlab lxml pillow requests
```

## 3) Build all
```
./macos/py2app/build_all_py2app.sh
```

Outputs:
`macos/release/StoryWeaverLauncher.app`
`macos/release/StoryWeaverEditor.app`
`macos/release/StoryWeaverUpdater.app`
`macos/release/StoryWeaverInstaller.app`

## Output names
py2app builds into `dist/` using these app folder names:
- `dist/launcher.app`
- `dist/editor.app`
- `dist/updater.app`
- `dist/installer.app`
