from __future__ import annotations

import re
from datetime import datetime

_LATEX_REPLACEMENTS = {
    "\\": r"\textbackslash{}",
    "&": r"\&",
    "%": r"\%",
    "$": r"\$",
    "#": r"\#",
    "_": r"\_",
    "{": r"\{",
    "}": r"\}",
    "~": r"\textasciitilde{}",
    "^": r"\textasciicircum{}",
}

_MARKDOWN_LINK_RE = re.compile(r"\[([^\]]+)\]\((https?://[^\)]+)\)")


def latex_escape(value: object) -> str:
    text = "" if value is None else str(value)
    return "".join(_LATEX_REPLACEMENTS.get(ch, ch) for ch in text)


def format_date(value: object) -> str:
    text = "" if value is None else str(value).strip()
    if not text:
        return ""

    for fmt, out in (("%Y", "%Y"), ("%Y-%m", "%b %Y"), ("%Y-%m-%d", "%d %b %Y")):
        try:
            return datetime.strptime(text, fmt).strftime(out)
        except ValueError:
            continue
    return text


def markdown_to_latex(value: object) -> str:
    text = "" if value is None else str(value)
    parts: list[str] = []
    last = 0

    for match in _MARKDOWN_LINK_RE.finditer(text):
        parts.append(latex_escape(text[last : match.start()]))
        label = latex_escape(match.group(1))
        url = match.group(2)
        parts.append(rf"\href{{{url}}}{{{label}}}")
        last = match.end()

    parts.append(latex_escape(text[last:]))
    return "".join(parts)
