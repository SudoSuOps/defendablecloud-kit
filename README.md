# DefendableCloud Kit

The portable runtime for a **DefendableCloud Node** — the engine room you drop on a box
(owner-compute, hosted, or hybrid) to make it run *defendable* agentic work.

> DefendableCore runs it · DefendableRouter routes it · DefendableOS verifies it · DefendableCloud proves it.

## What's in the kit
```
flightsheets/        the rulebooks — declared, deterministic eval specs (50)
assignments/         tasks issued to agents (filled at runtime)
skills/              Hermes skills — defendable-cloud-eval (run the eval lane)
bin/                 node_eval_runner.py — repeatable, schema-enforced evals
install.sh           lays the kit out into the runtime root
defendablelogo.png   the brand mark
```

## Installed runtime layout (`/opt/defendableos`)
```
/opt/defendableos
├── flightsheets/    rulebooks (installed from the kit)
├── assignments/     issued assignments
├── agents/
│   └── hermes-agent (pinned worker — source receipted before it runs work)
├── receipts/        proof ledger (commit receipts, incident receipts, …)
└── node_eval_runner.py
```

## Install
```bash
git clone git@github.com:SudoSuOps/defendablecloud-kit.git ~/defendablecloud-kit
cd ~/defendablecloud-kit && ./install.sh
```
Override the root with `DEFENDABLEOS_ROOT=/path ./install.sh`.

## Run an eval (schema-enforced by default)
```bash
JWT=<token> python3 /opt/defendableos/node_eval_runner.py \
    --sheet cre_memo_dscr_ltv_v1 --model hermes3:8b --tier small
# --no-constrain reproduces the free-form 'before' (format-masking)
```
The runner generates the agent submission under **grammar-constrained decoding** against the
flight sheet's required shape, so the referee measures capability (math/policy), not JSON format.

## Doctrine
- The referee is a **rulebook, not a judge** — math and code, flags not opinions.
- Agent source is **pinned + read before it runs work**.
- Agents **earn their lanes** by receipts; a human holds final authority before any receipt issues.
- Three flag classes: **work-defect** (fix & resubmit) · **deal-finding** (a true result) ·
  **stack-fit** (wrong model/compute for the lane — escalate, don't paper over).
