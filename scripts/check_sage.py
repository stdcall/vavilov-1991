"""Run the exact checks recorded in checks/sage-checks.json."""
import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parents[1]
MANIFEST = ROOT / 'checks/sage-checks.json'


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def load_records():
    records = json.loads(MANIFEST.read_text())
    keys = {'file', 'passages', 'coverage', 'limitations'}
    labels = set()
    for path in (ROOT / 'content').rglob('*.typ'):
        text = re.sub(r'(?m)^\s*//.*$', '', path.read_text())
        labels.update(re.findall(r'<([\w:.-]+)>', text))
    listed = []
    for record in records:
        if set(record) != keys:
            raise ValueError(f'Invalid Sage record: {record}')
        path = ROOT / record['file']
        if not path.is_file() or path.parent != ROOT / 'checks/sage':
            raise ValueError(f'Invalid Sage script: {record["file"]}')
        if not record['passages'] or not set(record['passages']) <= labels:
            raise ValueError(f'Missing passage labels: {record["file"]}')
        listed.append(path)
    actual = set((ROOT / 'checks/sage').glob('*.py'))
    if len(listed) != len(set(listed)) or set(listed) != actual:
        raise ValueError('Sage records must cover each check exactly once')
    return records


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--sage', default='sage')
    parser.add_argument('--timeout', type=int, default=900)
    parser.add_argument('--report', type=Path)
    args = parser.parse_args()
    records = load_records()
    version = subprocess.run([args.sage, '--version'], check=True,
                             capture_output=True, text=True).stdout.strip()
    inputs = {path.relative_to(ROOT).as_posix(): digest(path)
              for path in (ROOT / 'checks/sage').glob('*.py')}
    inputs.update({path.relative_to(ROOT).as_posix(): digest(path)
                   for path in (ROOT / 'content/diagrams').glob('*.json')})
    results = []
    for record in records:
        run = subprocess.run([args.sage, '-python', str(ROOT / record['file'])],
                             cwd=ROOT, capture_output=True, text=True,
                             timeout=args.timeout)
        results.append({**record, 'status': 'passed' if run.returncode == 0
                        else 'failed', 'returncode': run.returncode,
                        'output': run.stdout + run.stderr})
        print(results[-1]['status'], record['file'], flush=True)
        if run.returncode:
            print(run.stdout + run.stderr, flush=True)
    changed = [name for name, sha in inputs.items()
               if digest(ROOT / name) != sha]
    passed = not changed and all(r['returncode'] == 0 for r in results)
    if args.report:
        args.report.parent.mkdir(parents=True, exist_ok=True)
        args.report.write_text(json.dumps({
            'executed_at': datetime.now(timezone.utc).isoformat(),
            'status': 'passed' if passed else 'failed',
            'sage_version': version,
            'checker_sha256': digest(Path(__file__)),
            'input_sha256': inputs,
            'changed_during_run': changed,
            'results': results,
        }, indent=2) + '\n')
    raise SystemExit(0 if passed else 1)


if __name__ == '__main__':
    main()
