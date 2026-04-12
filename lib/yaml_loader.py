#!/usr/bin/env python3

from __future__ import annotations

import subprocess
from pathlib import Path
from typing import Any

import yaml


def _is_sops_encrypted(data: Any) -> bool:
    return isinstance(data, dict) and "sops" in data


def load_yaml_data(path: Path) -> Any:
    raw = path.read_text(encoding="utf-8")
    parsed = yaml.safe_load(raw)

    if _is_sops_encrypted(parsed):
        try:
            decrypted = subprocess.run(
                ["sops", "--decrypt", str(path)],
                check=True,
                capture_output=True,
                text=True,
            )
        except subprocess.CalledProcessError as exc:
            message = exc.stderr.strip() or str(exc)
            raise RuntimeError(f"sops decrypt failed: {message}") from exc
        return yaml.safe_load(decrypted.stdout)

    return parsed
