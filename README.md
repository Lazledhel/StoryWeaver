# Story Weaver

Story Weaver is a Windows desktop story-writing suite built around a launcher, an editor, an updater, and a backend service for activation and realtime features.

**Repository Layout**
1. `release/` prebuilt Windows binaries (launcher, editor, updater) ready to run.
1. `Launcher/` launcher application (PySide6) for activation, updates, and launching the editor.
1. `Editor/` main editor application (PySide6) plus project assets.
1. `updater/` update helper used by the launcher on Windows.
1. `Server/` FastAPI backend for activation keys and realtime services.
1. `installer/` NSIS installer script and packaged installer output.
1. `updates/` packaged update archives.

**Quick Start (Release Build)**
1. Run `release/StoryWeaverLauncher.exe`.
1. The launcher manages the editor installation and updates.

**Server (Local/Dev)**
1. From `Server/`, run:
   ```bash
   uvicorn main:app --host 0.0.0.0 --port 8594
   ```
1. Activation key generation (see `Server/Readme.txt` for details):
   ```bash
   curl -X POST "http://<host>:8594/activation/generate" \
     -H "Content-Type: application/json" \
     -d '{"admin_key":"CHANGE_ME_ADMIN_KEY","count":10,"prefix":"SW","length":24}'
   ```

**Configuration Notes**
1. The launcher server endpoint is set in `Launcher/Launcher.py` (`SERVER_URL`).
1. The editor version is defined in `Editor/editor.py` (`APP_VERSION`) and is written to `editor/version.txt` for launcher checks.

**Build Notes**
1. PyInstaller specs live in `Editor/editor.spec`, `Launcher/StoryWeaverLauncher.spec`, and `updater/updater.spec`.
1. The NSIS installer script is `installer/setup.nsi`.
