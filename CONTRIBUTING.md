## Contributing

Thanks for your interest in contributing to CVAC.

You can help in several ways:

1. Non-technical contributions
   - Found a design issue, typo, unclear docs, or UX problem?
   - Open an issue and describe what should be improved.

2. LaTeX and template improvements
   - If you are comfortable with LaTeX, you can improve spacing, typography, sections, or general template quality.
   - Open a pull request with screenshots (before/after when possible).

3. Python and CLI features
   - Add or improve validation, rendering logic, build workflow, or CLI commands.
   - Keep changes focused and explain the reason behind them in the PR.

## Development Setup

Use the Nix dev shell (recommended):

```bash
nix develop
```

Build all CVs:

```bash
task build
```

## Architecture

- Data: PyYAML
- Validation: Pydantic + email-validator
- Templating: Jinja2
- CLI: Typer
- Encryption: SOPS + age
- Build orchestration: go-task

## Repo Layout

```bash
.
├── cv
│   ├── cv.yaml               # Main CV data source (YAML, can be SOPS-encrypted)
│   └── cv.tex.jinja          # Jinja2 template that renders YAML data to TeX
├── lib
│   ├── cli.py                # Typer CLI commands (validate/render/compile entrypoints)
│   ├── compile.py            # TeX -> PDF compilation logic
│   ├── jinja_filters.py      # Custom Jinja filters used by the template
│   ├── render.py             # YAML + template rendering into TeX output
│   ├── validate.py           # Pydantic schema definitions and YAML validation
│   └── yaml_loader.py        # YAML loading helpers (including encrypted content flow)
├── tex
│   ├── fontawesome.sty       # Font Awesome package support for icons in CV
│   ├── fontawesome-full.sty  # Extended icon package support
│   ├── fonts                # Font assets used by the LaTeX class/template
│   └── resume-format.cls     # Core LaTeX class/layout system used by CV template
├── CONTRIBUTING.md           # Contribution guide for contributors
├── LICENSE                   # Project license
└── README.md                 # Project overview, usage, and screenshots
```

Notes:

- `build/` is generated content and should not be manually edited.
- Python source of truth lives in `lib/`, while CV content lives in `cv/`.
- Layout/styling behavior is mostly controlled by `cv/cv.tex.jinja` and `tex/resume-format.cls`.

## Contribution Guidelines

- Prefer small, focused pull requests.
- Keep commit messages clear and conventional when possible.
- If you change rendering/layout behavior, include a short visual or PDF output note.
- Avoid committing secrets or private data.

Thanks again for contributing.
