#!/usr/bin/env bash
# DefendableCloud Kit installer — turn any rig into a DefendableCloud node.
set -u
NODE_ID="${1:-mrd.defendable.eth}"
ROOT="${DEFENDABLEOS_ROOT:-/opt/defendableos}"
KIT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "DefendableCloud Kit → $ROOT (node $NODE_ID)"
if [ ! -d "$ROOT" ] || [ ! -w "$ROOT" ]; then
  sudo mkdir -p "$ROOT" 2>/dev/null && sudo chown -R "$(id -un):$(id -gn)" "$ROOT" 2>/dev/null \
    || { echo "!! cannot own $ROOT — set DEFENDABLEOS_ROOT to a writable path"; exit 0; }
fi
mkdir -p "$ROOT"/{cloud,node,agents,flightsheets/cloud,assignments,models,runs,receipts,logs,configs,bin}
cp "$KIT"/flightsheets/*.yaml       "$ROOT/flightsheets/"       2>/dev/null
cp "$KIT"/flightsheets/cloud/*.json "$ROOT/flightsheets/cloud/" 2>/dev/null
cp "$KIT"/assignments/*.yaml        "$ROOT/assignments/"        2>/dev/null
cp "$KIT"/configs/*.yaml            "$ROOT/configs/"            2>/dev/null
cp "$KIT"/bin/*                     "$ROOT/bin/"                2>/dev/null && chmod +x "$ROOT"/bin/*
cp "$KIT"/bin/node_eval_runner.py   "$ROOT/node_eval_runner.py" 2>/dev/null
cp "$KIT"/defendablelogo.png "$ROOT/" 2>/dev/null
cp "$KIT"/node.env.example "$ROOT/node/node.env.example" 2>/dev/null
python3 -c "import yaml" 2>/dev/null || pip install --user -q pyyaml 2>/dev/null || pip3 install --user -q pyyaml 2>/dev/null
if [ -d "$HOME/.hermes" ]; then mkdir -p "$HOME/.hermes/skills/domain"; cp -r "$KIT"/skills/defendable-cloud-eval "$HOME/.hermes/skills/domain/" 2>/dev/null; fi
bash "$ROOT/bin/defendable-node-init" "$NODE_ID"
echo "flightsheets: $(ls "$ROOT"/flightsheets/*.yaml 2>/dev/null|wc -l) · cloud-rulebooks: $(ls "$ROOT"/flightsheets/cloud/*.json 2>/dev/null|wc -l) · assignments: $(ls "$ROOT"/assignments/*.yaml 2>/dev/null|wc -l)"
echo "PATH: export PATH=\"$ROOT/bin:\$PATH\"   then:  defendable-health  ·  defendable-run assignment-001-node-readiness.yaml"
