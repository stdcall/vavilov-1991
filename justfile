# Machine settings such as LEAN_MATHLIB may be kept in a local .env file.
set dotenv-load

python := "uv run --locked python"

default: build

# Validated PDF, with cached no-op when source files have not changed.
build:
    {{python}} scripts/project.py build

# CI gate: format, lint, PDF links/layout, tests, corrections, no-notes PDF.
check:
    {{python}} scripts/project.py check

# Formatter check, source rules and the evaluated document (T000-T099).
lint:
    {{python}} scripts/project.py lint

# Format the Typst sources in place (Typstyle with the Tinymist settings).
fmt:
    {{python}} scripts/project.py fmt

# Tests of mathematical audits and PDF navigation validation.
test:
    {{python}} scripts/project.py test

# The reader's list of corrections: build/vavilov-1991.corrections.pdf
corrections:
    {{python}} scripts/project.py corrections

# The book without editorial notes: build/vavilov-1991.no-notes.pdf
build-no-notes:
    {{python}} scripts/project.py build-no-notes

# Remove build/ and the build cache (`cache` in config/project.json).
clean:
    {{python}} scripts/project.py clean

# Exact Sage checks, with passage bindings and scope in checks/sage-checks.json.
check-sage:
    {{python}} scripts/check_sage.py

# Lean checks of checks/lean-proofs.json: compile, no warnings, standard
# axioms. With LEAN_MATHLIB set, against a prebuilt mathlib checkout of the
# pinned commit (nothing is built or fetched); otherwise in checks/lean after
# `lake build` there, as CI does.
check-lean:
    {{python}} checks/lean/check_axioms.py

# Advisory prose check (Harper); dictionary and rules shared with VS Code.
check-prose:
    {{python}} scripts/check_prose.py
