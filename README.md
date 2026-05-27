# DefendableCloud Kit

The installable runtime that turns any rig into a **DefendableCloud Node** — the engine room
for running *defendable* agentic work (owner-compute, hosted, or hybrid).

> DefendableCore runs it · DefendableRouter routes it · DefendableOS verifies it · DefendableCloud proves it.
> **Hermes can be the first worker, but DefendableOS owns the rulebook.**

## The doctrine
| | |
|---|---|
| **Flightsheet** | how the work should be flown (the plan / rulebook) |
| **Assignment** | the specific mission (the work order) |
| **Run** | what actually happened |
| **Receipt** | proof it happened |
| **Verdict** | HONEY (pass) · JELLY (warning) · PROPOLIS (fail) |

## Kit layout
```
defendablecloud-kit/
├── install.sh              lay the kit onto a node + init it
├── node.env.example
├── flightsheets/           node/runtime plans (YAML)
│   ├── rig-smoke-test.yaml  hermes-agent-eval.yaml
│   ├── sglang-runtime-test.yaml  vllm-runtime-test.yaml  openclaw-redteam.yaml
│   └── cloud/              the 50 Cloud eval rulebooks (JSON) — agent-work evals
├── assignments/            work orders (YAML): node-readiness, hermes-memory, runtime-compare, agent-safety
├── configs/                models.yaml · runtimes.yaml · policy.yaml
├── skills/defendable-cloud-eval/   Hermes skill — run the Cloud eval lane
├── bin/                    defendable-node-init · defendable-health · defendable-run · defendable-receipt · node_eval_runner.py
└── systemd/                defendable-agent.service · defendable-runner.service
```

## Installed runtime (`/opt/defendableos`)
```
node/ (node.env, identity.json) · agents/hermes-agent · flightsheets/ (+cloud/)
assignments/ · configs/ · models/ · runs/ · receipts/ · logs/ · bin/
```

## Install & run
```bash
git clone git@github.com:SudoSuOps/defendablecloud-kit.git ~/defendablecloud-kit
cd ~/defendablecloud-kit && bash install.sh mrd.defendable.eth
export PATH="/opt/defendableos/bin:$PATH"
defendable-health
defendable-run assignment-001-node-readiness.yaml      # → run/ + receipt + VERDICT
defendable-receipt list
```

## Notes
- `defendable-run` is deterministic and node-level: it loads the assignment, finds its
  flightsheet, runs the declared `checks`, and writes `runs/<id>/{report.md,result.json}` +
  a hashed `receipts/<id>.txt` with a verdict. Unimplemented checks are honestly `skip`ped.
- The Cloud agent-work eval lane (CRE underwriting etc.) is `bin/node_eval_runner.py` against
  `flightsheets/cloud/*.json` — schema-enforced by default.
- Governance (`configs/policy.yaml`): human approval before receipts/client output, no outbound,
  agent source pinned, agents earn lanes. Controllable autonomy.
