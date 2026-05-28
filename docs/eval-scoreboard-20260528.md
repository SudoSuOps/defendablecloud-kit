# DefendableCloud Eval Scoreboard
**Date:** 2026-05-28 · **Node:** mrd.defendable.eth · **GPU:** RTX 5090 32GB · **Runtime:** Ollama

## Models Evaluated
| Model | Size | tok/s | Source |
|-------|------|-------|--------|
| hermes3:8b | 4.7GB | ~260 | NousResearch (general orchestrator) |
| swarmatlas-9b | 19GB | ~80 | Qwen3.5-9B (full-stack eval brain) |

## Results by Domain

### Finance (5 sheets) — LANE EARNED by Atlas
| Sheet | Hermes 8B | Atlas 9B |
|-------|-----------|----------|
| compound_interest_roi | 84.1 HONEY | 84.1 HONEY (R1) |
| ebitda_npv | 0.0 PROPOLIS | 79.5 JELLY |
| gross_net_margin | 84.1 HONEY | 86.4 HONEY |
| ratio_analysis | 80.4 HONEY (R1) | 80.4 HONEY (R1) |
| wacc_calculation | 80.8 HONEY (R3) | 80.8 HONEY (R3) |
| **Totals** | **4H 0J 1P** | **4H 1J 0P** |

### CRE Underwriting (8 sheets) — NOT EARNED
| Sheet | Hermes 8B | Atlas 9B |
|-------|-----------|----------|
| cash_on_cash | 72.1 JELLY | 72.1 JELLY (R3) |
| dscr_ltv | 0.0 PROPOLIS | 80.4 HONEY |
| egi_vacancy | 74.3 JELLY | 74.3 JELLY (R1) |
| equity_multiple_irr | 0.0 PROPOLIS | 80.4 HONEY (R2) |
| noi_cap_rate | 65.0 JELLY (R3) | 60.0 JELLY (R3) |
| price_per_unit_sqft | 60.8 JELLY (R3) | 0.0 PROPOLIS |
| rent_roll_analysis | 67.9 JELLY | 67.9 JELLY |
| risk_assessment | 0.0 PROPOLIS | 0.0 PROPOLIS |
| **Totals** | **0H 5J 3P** | **2H 4J 2P** |

### GenAI (5 sheets) — NOT EARNED
| Sheet | Hermes 8B | Atlas 9B |
|-------|-----------|----------|
| chain_of_thought | 70.0 JELLY (R3) | 70.0 JELLY |
| error_disclosure | 80.0 HONEY | 0.0 PROPOLIS |
| evidence_citation | 63.9 JELLY (R3) | 63.9 JELLY (R3) |
| instruction_following | 78.8 JELLY | 82.7 HONEY |
| schema_compliance | 75.0 JELLY | 75.0 JELLY |
| **Totals** | **1H 3J 1P** | **1H 3J 1P** |

### Compute (7 sheets) — STACK_FIT
| All 7 sheets | PROPOLIS (25-35) | PROPOLIS (25-34) |
| **Totals** | **0H 0J 7P** | **0H 0J 7P** |
> Needs real benchmark data from instrumented hardware, not LLM generation.

### Dataset QA (7 sheets) — STACK_FIT
| All 7 sheets | PROPOLIS (29-39) | PROPOLIS (31-38) |
| **Totals** | **0H 0J 7P** | **0H 0J 7P** |
> Needs real dataset analysis tooling, not LLM generation.

## Grand Totals (32 sheets evaluated)
| | Hermes 8B | Atlas 9B |
|---|-----------|----------|
| HONEY | 5 | 7 |
| JELLY | 8 | 8 |
| PROPOLIS | 19 | 17 |
| **Score** | 15.6% HONEY | 21.9% HONEY |

## Lane Eligibility (>=3 HONEY, 0 PROPOLIS in domain)
| Domain | Hermes 8B | Atlas 9B |
|--------|-----------|----------|
| Finance | BLOCKED (1 PROPOLIS) | **APPROVED** (4H, 0P) |
| CRE | NOT EARNED (0H) | NOT EARNED (2H, 2P) |
| GenAI | NOT EARNED (1H, 1P) | NOT EARNED (1H, 1P) |
| Compute | STACK_FIT | STACK_FIT |
| Dataset | STACK_FIT | STACK_FIT |

## Key Findings
1. **Finance is the first earned lane** — Atlas-9B qualifies (4 HONEY, 0 PROPOLIS)
2. **CRE math separates 9B from 8B** — Atlas earned 2 HONEYs Hermes couldn't (DSCR/LTV, equity multiple/IRR)
3. **Repair loop works** — WACC went from JELLY → HONEY in 3 attempts for both models
4. **Compute + Dataset = stack_fit** — these need real data/instrumentation, not generation
5. **JSON reliability** is the #1 blocker after math — 3-4 PROPOLIS per domain from parse failures
6. **The prompt is king** — both models ace schema (11/11 keys) when JSON parses

## Recommendations
- **Finance lane:** Deploy Atlas-9B as approved agent
- **CRE lane:** Fine-tune SwarmCapitalMarkets-4B (45K CRE pairs ready) — the base models can't nail multi-step underwriting math
- **Compute/Dataset:** Wire real instrumentation (nvidia-smi, dataset profilers) into the eval lane — these are tooling problems, not model problems
- **JSON reliability:** Increase num_predict for complex sheets, or pre-validate with a schema linter before scoring

## Doctrine
The referee is a rulebook, not a judge. Agents earn their lanes.
A human holds final authority.
