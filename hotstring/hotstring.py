import shutil
import tomllib
import unicodedata
from pathlib import Path
from typing import TYPE_CHECKING

import cyclopts
import msgspec

if TYPE_CHECKING:
    from collections.abc import Generator, Iterator


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

    def comment(self, c: str) -> str:
        if len(c) != 1:
            return ''

        return f'  ; U+{ord(c):04X} {unicodedata.name(c)}'

    def __call__(
        self,
        src: str,
        dst: str,
        *,
        comment: bool,
        pad: int | None = None,
    ) -> str:
        txt = f':{self.option}:{self.prefix}{src}{self.suffix}::{dst}'
        if comment:
            if pad:
                txt = f'{txt:{pad}}'
            txt += self.comment(dst)
        return txt

    def __iter__(self) -> Iterator[str]:
        pad = max(len(self(*x, comment=False)) for x in self.v.items())
        for src, dst in self.v.items():
            yield self(src, dst, pad=pad, comment=True)


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


app = cyclopts.App()


@app.command
def ahk(
    config: Path | None = None,
    *,
    template: Path = Path('script.template.ahk'),
    script: Path = Path('script.ahk'),
    encoding: str = 'utf-8',
    hotstring: bool = False,
) -> None:
    if not hotstring:
        shutil.copy2(template, script)
        return

    config = config or Path(__file__).parent / 'hotstring.toml'
    hg = HotstringGroups(tomllib.loads(config.read_text(encoding)))
    script.write_text(
        template.read_text(encoding).replace('    ;{hotstrings}', str(hg)),
        encoding=encoding,
    )


def _espanso(group: str, matches: dict[str, str]) -> Generator[dict[str, str]]:
    t = '\\' if group in {'latex', 'greek', 'subscript', 'superscript'} else ':'
    for trigger, replace in matches.items():
        yield {
            'trigger': f'{t}{trigger}{t}',
            'replace': replace,
            'label': f'{replace} U+{ord(replace):04X} {unicodedata.name(replace)}'
            if len(replace) == 1
            else replace,
        }


@app.command
def espanso(
    config: Path | None = None,
    encoding: str = 'utf-8',
) -> None:
    config = config or Path(__file__).parent / 'hotstring.toml'
    data = msgspec.toml.decode(
        config.read_text(encoding), type=dict[str, dict[str, str]]
    )

    output = Path('espanso')
    output.mkdir(exist_ok=True)
    output.joinpath('.gitignore').write_text('*')

    for group, matches in data.items():
        yaml = output / f'{group}.yaml'
        buf = msgspec.yaml.encode({'matches': list(_espanso(group, matches))})
        yaml.write_bytes(buf)


if __name__ == '__main__':
    app()
