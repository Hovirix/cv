#!/usr/bin/env python3

from __future__ import annotations
import os
import subprocess
from pathlib import Path


def compile_tex(tex_path: Path, out_dir: Path, texinputs: str, tex_cwd: Path) -> Path:
    repo_root = Path.cwd()
    tex_path = tex_path.resolve()
    tex_stem = tex_path.stem
    out_dir = out_dir.resolve()
    out_dir.mkdir(parents=True, exist_ok=True)
    tex_cwd = (repo_root / tex_cwd).resolve()

    env = os.environ.copy()
    existing = env.get("TEXINPUTS", "")
    env["TEXINPUTS"] = f"{texinputs}{existing}"

    command = [
        "xelatex",
        "-interaction=nonstopmode",
        "-halt-on-error",
        "-output-directory",
        str(out_dir),
        str(tex_path),
    ]
    subprocess.run(command, check=True, env=env, cwd=tex_cwd)
    return out_dir / f"{tex_stem}.pdf"
