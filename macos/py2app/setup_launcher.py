from pathlib import Path
from setuptools import setup

ROOT_DIR = Path(__file__).resolve().parents[2]
MAC_DIR = ROOT_DIR / "macos"
APP_NAME = "launcher"

APP = [str(ROOT_DIR / "Launcher" / "launcher.py")]

OPTIONS = {
    "argv_emulation": False,
    "iconfile": str(MAC_DIR / "assets" / "storyweaver.icns"),
    "packages": ["requests", "cryptography", "PySide6"],
    "includes": [],
    "resources": [str(ROOT_DIR / "storyweaver.ico")],
    "plist": {
        "CFBundleName": "StoryWeaverLauncher",
        "CFBundleDisplayName": "StoryWeaver Launcher",
        "CFBundleIdentifier": "com.storyweaver.launcher",
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
