import tomllib
from pathlib import Path


class Hotstring:
    def __init__(
        self,
        v: dict[str, str],
        /,
        option='?*',
        prefix: str = '\\',
        suffix: str | None = None,
    ):
        self.v = v
        self.option = option
        self.prefix = prefix
        self.suffix = suffix or ''

    def __iter__(self):
        for src, dst in self.v.items():
            yield f':{self.option}:{self.prefix}{src}{self.suffix}::{dst}'


if __name__ == '__main__':
    config = Path('hotstring.toml')
    script = Path('hotstring.ahk')

    data: dict[str, dict[str, str]] = tomllib.loads(config.read_text())

    with script.open('w') as f:
        for group, hotstring in data.items():
            f.write(f'; {group}\n')

            option = '?*C' if group in {'greek', 'arrow'} else '?*'
            suffix = None if group == 'subscript_superscript' else '\\'
            for line in Hotstring(hotstring, option=option, suffix=suffix):
                f.write(f'{line}\n')

            f.write('\n')
