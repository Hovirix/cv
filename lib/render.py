#!/usr/bin/env python3

from __future__ import annotations
from datetime import datetime, timezone
from pathlib import Path

from jinja2 import Environment, FileSystemLoader, StrictUndefined

from lib.jinja_filters import format_date, latex_escape, markdown_to_latex
from lib.validate import CVSchema
from lib.yaml_loader import load_yaml_data


def _pdf_timestamp() -> str:
    now = datetime.now(timezone.utc)
    return now.strftime("D:%Y%m%d%H%M%S+00'00'")


def render_cv(yaml_path: Path, template_path: Path, output_path: Path) -> None:
    data = load_yaml_data(yaml_path)
    validated = CVSchema.model_validate(data)

    env = Environment(
        loader=FileSystemLoader(str(template_path.parent)),
        autoescape=False,
        undefined=StrictUndefined,
        trim_blocks=True,
        lstrip_blocks=True,
    )
    env.filters["latex_escape"] = latex_escape
    env.filters["format_date"] = format_date
    env.filters["markdown_to_latex"] = markdown_to_latex

    template = env.get_template(template_path.name)
    payload = validated.model_dump()
    payload["compilation_timestamp"] = _pdf_timestamp()

    rendered = template.render(**payload)

    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(rendered, encoding="utf-8")
