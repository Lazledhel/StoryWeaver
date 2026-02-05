from pathlib import Path
from setuptools import setup

ROOT_DIR = Path(__file__).resolve().parents[2]
MAC_DIR = ROOT_DIR / "macos"
APP_NAME = "installer"

APP = [str(MAC_DIR / "installer" / "installer.py")]

OPTIONS = {
    "argv_emulation": False,
    "iconfile": str(MAC_DIR / "assets" / "storyweaver.icns"),
    "packages": [],
    "resources": [
        str(MAC_DIR / "installer" / "resources"),
    ],
    "plist": {
        "CFBundleName": "StoryWeaverInstaller",
        "CFBundleDisplayName": "StoryWeaver Installer",
        "CFBundleIdentifier": "com.storyweaver.installer",
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
