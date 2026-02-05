from pathlib import Path
from setuptools import setup

ROOT_DIR = Path(__file__).resolve().parents[2]
MAC_DIR = ROOT_DIR / "macos"
APP_NAME = "updater"

APP = [str(ROOT_DIR / "updater" / "updater.py")]

OPTIONS = {
    "argv_emulation": False,
    "iconfile": str(MAC_DIR / "assets" / "storyweaver.icns"),
    "packages": ["requests", "cryptography"],
    "includes": ["_socket"],
    "resources": [],
    "plist": {
        "CFBundleName": "StoryWeaverUpdater",
        "CFBundleDisplayName": "StoryWeaver Updater",
        "CFBundleIdentifier": "com.storyweaver.updater",
        "CFBundleShortVersionString": "3.2.1",
        "CFBundleVersion": "3.2.1",
    },
}

setup(
    app=APP,
    options={"py2app": OPTIONS},
    setup_requires=["py2app"],
    name=APP_NAME,
)
