"""Advisory Harper check of narrative Typst files.

Use the workspace dictionary, dialect and disabled rules configured for VS Code.
Positional files restrict the check; by default check numbered chapters 00–79.
Findings are advisory, but runner failures exit unsuccessfully.
"""
import argparse
import json
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def editor_settings():
    return json.loads((ROOT / '.vscode/settings.json').read_text())


def disabled_rules():
    settings = editor_settings()
    linters = dict(settings.get('harper-ls.linters', {}))
    for key, value in settings.items():
        if key.startswith('harper.linters.'):
            linters[key.rsplit('.', 1)[-1]] = value
    return sorted(name for name, on in linters.items() if not on)


def dialect():
    settings = editor_settings()
    return (settings.get('harper.dialect')
            or settings.get('harper-ls.dialect', 'American')).lower()


def lint(paths):
    command = ['harper-cli', 'lint', '--quiet', '--format', 'json',
               '--dialect', dialect()]
    dictionary = ROOT / editor_settings().get(
        'harper.workspaceDictPath', 'checks/harper-dictionary.txt')
    if not dictionary.is_file():
        raise FileNotFoundError(f'Workspace dictionary not found: {dictionary}')
    command += ['--user-dict-path', str(dictionary)]
    for rule in disabled_rules():
        command += ['--ignore', rule]
    result = subprocess.run(command + [str(p) for p in paths],
                            capture_output=True, text=True)
    findings_exit = (result.returncode == 1 and
                     result.stderr.strip().endswith('Error: Lints were found'))
    if result.returncode and not findings_exit:
        raise RuntimeError(f"Harper exited with {result.returncode}: "
                           f"{result.stderr.strip() or result.stdout.strip()}")
    start = result.stdout.find("[")
    if start < 0:
        raise ValueError("Harper returned no JSON report")
    prefix = result.stdout[:start].strip()
    if prefix and any(not line.startswith("Note:") for line in prefix.splitlines()):
        raise ValueError("Unexpected text before Harper JSON")
    report, end = json.JSONDecoder().raw_decode(result.stdout[start:])
    if result.stdout[start + end:].strip():
        raise ValueError("Unexpected text after Harper JSON")
    if not isinstance(report, list) or len(report) != len(paths):
        raise ValueError("Harper report does not cover the requested files")
    for item in report:
        if not isinstance(item, dict) or not isinstance(item.get("file"), str) \
                or not isinstance(item.get("lints"), list):
            raise ValueError("Invalid Harper report record")
        for finding in item["lints"]:
            if not isinstance(finding, dict) or not {
                    "line", "column", "rule", "matched_text", "message"
            } <= finding.keys():
                raise ValueError("Invalid Harper finding")
    if findings_exit and not any(item['lints'] for item in report):
        raise ValueError('Harper reported findings but supplied none')
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("files", nargs="*", type=Path,
                        help="narrative .typ files to check (default: chapters 00–79)")
    args = parser.parse_args()
    sources = args.files or sorted(p for p in (ROOT / "content").glob("*.typ")
                                   if re.match(r"[0-7][0-9]-", p.name))
    for path in sources:
        if not path.is_file() or path.suffix != ".typ" \
                or not re.match(r"[0-7][0-9]-", path.name):
            parser.error(f"Not a numbered narrative Typst file: {path}")
    try:
        report = lint(sources)
    except (OSError, RuntimeError, ValueError) as error:
        parser.exit(1, f"prose check failed: {error}\n")
    findings = [(item['file'], lint_item)
                for item in report for lint_item in item['lints']]
    for name, item in findings:
        print(f'  {name}:{item["line"]}:{item["column"]}  '
              f'{item["rule"]}: {item["matched_text"]!r} — {item["message"]}')
    kinds = {}
    for _, item in findings:
        kinds[item['rule']] = kinds.get(item['rule'], 0) + 1
    print(f'\nprose: {len(findings)} findings '
          '(advisory, the build does not depend on them)')
    for rule, count in sorted(kinds.items(), key=lambda it: -it[1])[:15]:
        print(f'  {count:4d}  {rule}')


if __name__ == '__main__':
    main()
