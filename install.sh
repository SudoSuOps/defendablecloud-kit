#!/usr/bin/env bash
# DefendableCloud Kit installer — lay the kit out into a node's runtime root.
# Fail-open discipline: never hard-abort the box; report and exit clean.
set -u

ROOT="${DEFENDABLEOS_ROOT:-/opt/defendableos}"
KIT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "DefendableCloud Kit → $ROOT"

# Ensure the runtime root exists and is writable (sudo only if we must).
if [ ! -d "$ROOT" ] || [ ! -w "$ROOT" ]; then
  sudo mkdir -p "$ROOT" 2>/dev/null && sudo chown -R "$(id -un):$(id -gn)" "$ROOT" 2>/dev/null \
    || { echo "!! cannot create/own $ROOT — set DEFENDABLEOS_ROOT to a writable path"; exit 0; }
fi

mkdir -p "$ROOT/flightsheets" "$ROOT/assignments" "$ROOT/receipts" "$ROOT/agents"

# Flightsheets — the rulebooks.
cp "$KIT"/flightsheets/*.json "$ROOT/flightsheets/" 2>/dev/null
echo "  flightsheets: $(ls "$ROOT"/flightsheets/*.json 2>/dev/null | wc -l)"

# Eval-runner.
cp "$KIT"/bin/node_eval_runner.py "$ROOT/node_eval_runner.py" 2>/dev/null && chmod +x "$ROOT/node_eval_runner.py" 2>/dev/null
echo "  runner: $([ -f "$ROOT/node_eval_runner.py" ] && echo ok || echo missing)"

# Hermes skill — installed only if Hermes is present (the worker substrate).
if [ -d "$HOME/.hermes" ]; then
  mkdir -p "$HOME/.hermes/skills/domain"
  cp -r "$KIT"/skills/defendable-cloud-eval "$HOME/.hermes/skills/domain/" 2>/dev/null \
    && echo "  hermes skill: defendable-cloud-eval installed"
else
  echo "  hermes: not present (skip skill) — install the agent under $ROOT/agents/"
fi

# Brand mark.
cp "$KIT/defendablelogo.png" "$ROOT/defendablelogo.png" 2>/dev/null

echo "runtime ready:"; ls -1 "$ROOT"
