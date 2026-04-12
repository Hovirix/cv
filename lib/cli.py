#!/usr/bin/env python3

from __future__ import annotations

from pathlib import Path

import typer

app = typer.Typer(help="CV tooling CLI")


@app.command("validate")
def validate_cmd(
    yaml_path: Path = typer.Option(..., "--yaml-path"),
) -> None:
    from lib.validate import validate_source

    raise SystemExit(validate_source(yaml_path))


@app.command("render")
def render_cmd(
    yaml_path: Path = typer.Option(..., "--yaml-path"),
    template_path: Path = typer.Option(..., "--template-path"),
    out: Path = typer.Option(..., "--out"),
) -> None:
    from lib.render import render_cv

    render_cv(yaml_path, template_path, out)
    typer.echo(f"Rendered {out}")


@app.command("compile")
def compile_cmd(
    tex_path: Path = typer.Option(..., "--tex-path"),
    out_dir: Path = typer.Option(..., "--out-dir"),
    texinputs: str = typer.Option(..., "--texinputs"),
    tex_cwd: Path = typer.Option(..., "--tex-cwd"),
) -> None:
    from lib.compile import compile_tex

    pdf_path = compile_tex(tex_path, out_dir, texinputs, tex_cwd)
    typer.echo(f"Compiled {pdf_path}")


@app.command("pdf")
def pdf_cmd(
    yaml_path: Path = typer.Option(..., "--yaml-path"),
    template_path: Path = typer.Option(..., "--template-path"),
    out: Path = typer.Option(..., "--out"),
    texinputs: str = typer.Option(..., "--texinputs"),
    tex_cwd: Path = typer.Option(..., "--tex-cwd"),
) -> None:
    from lib.compile import compile_tex
    from lib.render import render_cv

    render_cv(yaml_path, template_path, out)
    typer.echo(f"Rendered {out}")
    pdf_path = compile_tex(out, out.parent, texinputs, tex_cwd)
    typer.echo(f"Compiled {pdf_path}")


def main() -> None:
    app()


if __name__ == "__main__":
    main()
