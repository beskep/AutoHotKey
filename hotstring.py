from __future__ import annotations

import tomllib
from pathlib import Path
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from collections.abc import Iterator


class Hotstrings:
    def __init__(
        self,
        v: dict[str, str],
        /,
        option: str = '?*',
        prefix: str = '\\',
        suffix: str | None = None,
    ) -> None:
        self.v = v
        self.option = option
        self.prefix = prefix
        self.suffix = suffix or ''

    def __iter__(self) -> Iterator[str]:
        for src, dst in self.v.items():
            yield f':{self.option}:{self.prefix}{src}{self.suffix}::{dst}'


class HotstringGroups:
    def __init__(
        self,
        v: dict[str, dict[str, str]],
        /,
        prefix: str = '\\',
        suffix: str | None = None,
    ) -> None:
        self.v = v
        self.prefix = prefix
        self.suffix = suffix or ''

    def __iter__(self) -> Iterator[str | None]:
        for group, v in self.v.items():
            yield f'; {group}'
            yield from Hotstrings(
                v,
                option='?*C' if group in {'greek', 'arrow'} else '?*',
                suffix=None if group == 'subscript_superscript' else '\\',
            )
            yield None

    def __str__(self) -> str:
        return '\n'.join(f'    {x}' if x else '' for x in self)


if __name__ == '__main__':
    config = Path('hotstring.toml')
    template = Path('script.template.ahk')
    script = Path('script.ahk')
    encoding = 'utf-8'

    hg = HotstringGroups(tomllib.loads(config.read_text(encoding)))
    script.write_text(
        template.read_text(encoding).replace('    ;{hotstrings}', str(hg)),
        encoding=encoding,
    )
