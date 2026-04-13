#!/usr/bin/env python3

from __future__ import annotations

import sys
from pathlib import Path
from typing import Annotated

from pydantic import (
    BaseModel,
    EmailStr,
    HttpUrl,
    StringConstraints,
    ValidationError,
    Field,
)

from lib.yaml_loader import load_yaml_data

ISODate = (
    Annotated[
        str,
        StringConstraints(
            pattern=r"^(\d{4}(-(0[1-9]|1[0-2])(-(0[1-9]|[12]\d|3[01]))?)?|Present)$"
        ),
    ]
    | Annotated[int, Field(ge=1900, le=2100)]
)

GitRepo = Annotated[
    str,
    StringConstraints(pattern=r"^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$")
]


class Hero(BaseModel):
    name: str
    surname: str
    email: EmailStr
    location: str
    github: HttpUrl
    description: str


class ExperienceItem(BaseModel):
    name: str
    role: str
    startDate: ISODate
    endDate: ISODate
    highlights: list[str]


class EducationItem(BaseModel):
    institution: str
    area: str
    studyType: str
    startDate: ISODate
    endDate: ISODate
    highlights: list[str]


class SkillItem(BaseModel):
    name: str
    tags: list[str]


class AwardItem(BaseModel):
    title: str
    event: str
    location: str
    date: ISODate


class CertificateItem(BaseModel):
    title: str
    issuer: str
    date: ISODate


class ProjectItem(BaseModel):
    name: str
    desc: str
    git: GitRepo
    url: HttpUrl


class Footer(BaseModel):
    sentence: str


class CVSchema(BaseModel):
    hero: Hero
    experience: list[ExperienceItem] = Field(default_factory=list)
    education: list[EducationItem] = Field(default_factory=list)
    skills: list[SkillItem] = Field(default_factory=list)
    awards: list[AwardItem] = Field(default_factory=list)
    certificates: list[CertificateItem] = Field(default_factory=list)
    projects: list[ProjectItem] = Field(default_factory=list)
    footer: Footer = Field(default_factory=Footer)


def validate_yaml_file(path: Path) -> list[str]:
    try:
        data = load_yaml_data(path)
    except FileNotFoundError as exc:
        return [f"cannot read file: {exc}"]
    except Exception as exc:
        return [f"invalid YAML syntax: {exc}"]

    if data is None:
        return ["YAML file is empty"]

    try:
        CVSchema.model_validate(data)
        return []
    except ValidationError as exc:
        errors: list[str] = []
        for err in exc.errors():
            location = ".".join(str(part) for part in err["loc"])
            errors.append(f"{location}: {err['msg']}")
        return errors


def validate_source(yaml_path: Path) -> int:
    errors = validate_yaml_file(yaml_path)
    if errors:
        print(f"FAIL: {yaml_path}")
        for err in errors:
            print(f"  - {err}")
        print(f"\nValidation failed with {len(errors)} error(s).")
        return 1

    print(f"PASS: {yaml_path}")
    print("\nSource YAML validation checks passed.")
    return 0


def main(argv: list[str] | None = None) -> int:
    args = argv if argv is not None else sys.argv[1:]
    if len(args) != 1:
        print("usage: python lib/validate.py <yaml-path>")
        return 2
    yaml_path = Path(args[0])
    return validate_source(yaml_path)


if __name__ == "__main__":
    raise SystemExit(main())
