import os
import shutil
import sys
import tkinter as tk
from tkinter import ttk, messagebox


APP_NAME = "StoryWeaver"
TARGET_DIR = f"/Applications/{APP_NAME}"

APPS = [
    "StoryWeaverLauncher.app",
    "StoryWeaverEditor.app",
    "StoryWeaverUpdater.app",
]


def _base_dir() -> str:
    if getattr(sys, "frozen", False):
        # PyInstaller one-dir .app
        return os.path.dirname(sys.executable)
    return os.path.dirname(os.path.abspath(__file__))


def _apps_dir() -> str:
    return os.path.join(_base_dir(), "resources", "apps")


def _copy_app(src: str, dst: str):
    if os.path.exists(dst):
        shutil.rmtree(dst, ignore_errors=True)
    shutil.copytree(src, dst)


def install(progress: ttk.Progressbar, label: tk.Label, root: tk.Tk):
    apps_dir = _apps_dir()
    if not os.path.isdir(apps_dir):
        messagebox.showerror("Installer", f"Missing resources: {apps_dir}")
        return

    os.makedirs(TARGET_DIR, exist_ok=True)

    total = len(APPS)
    progress["maximum"] = total
    progress["value"] = 0

    for idx, app in enumerate(APPS, start=1):
        src = os.path.join(apps_dir, app)
        dst = os.path.join(TARGET_DIR, app)
        if not os.path.exists(src):
            messagebox.showerror("Installer", f"Missing app bundle: {src}")
            return
        label.config(text=f"Installing {app} ({idx}/{total})...")
        root.update_idletasks()
        _copy_app(src, dst)
        progress["value"] = idx

    label.config(text="Done.")
    messagebox.showinfo("Installer", f"Installed to {TARGET_DIR}")


def main():
    root = tk.Tk()
    root.title("StoryWeaver Installer")
    root.geometry("420x220")
    root.resizable(False, False)

    frm = ttk.Frame(root, padding=16)
    frm.pack(fill="both", expand=True)

    ttk.Label(frm, text="Install StoryWeaver to /Applications").pack(anchor="w")
    lbl = ttk.Label(frm, text="Ready to install.")
    lbl.pack(anchor="w", pady=(8, 12))

    progress = ttk.Progressbar(frm, mode="determinate")
    progress.pack(fill="x")

    btn = ttk.Button(frm, text="Install", command=lambda: install(progress, lbl, root))
    btn.pack(pady=(16, 0))

    root.mainloop()


if __name__ == "__main__":
    main()
