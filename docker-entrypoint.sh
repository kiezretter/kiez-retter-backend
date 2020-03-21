#!/bin/bash
set -euo pipefail

if [[ -n "${RUN_MIGRATIONS:-}" ]]; then
    >&2 echo Running migrations..
    rails db:migrate
fi

exec "$@"