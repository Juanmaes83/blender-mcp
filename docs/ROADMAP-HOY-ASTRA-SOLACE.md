# ROADMAP HOY — Astra + Blender + SOLACE

Date: 2026-09-04
Branch: `lab/astra-sept-2026`

## Mission for today

Finish the day with a verified vertical slice, not with a pile of setup work.

**Target outcome:**

1. know whether the OpenAI API account and/or Codex can use `gpt-6-astra` today;
2. have Codex/Astra connected to Blender through the September Blender MCP LAB;
3. prove the visual feedback loop with scene inspection + screenshot + one controlled edit;
4. ingest the SOLACE reference package into a structured source manifest;
5. create the first SOLACE architectural blockout;
6. if the previous gates are stable, produce a first low-cost living -> dining -> kitchen camera preview inspired by the first ~14 s of the supplied walkthrough.

UE5 is explicitly **not** a success requirement for today. It begins only after the Blender loop is stable.

---

## Definition of DONE today

The day is successful if we reach at least **G3**, with **G4/G5 as stretch but realistic targets**.

- **G0 — Astra access resolved**
  - direct API test produces a definitive success or `model_not_found`/access result;
  - Codex model availability tested independently;
  - exact result recorded.

- **G1 — Blender MCP health**
  - Blender addon active;
  - MCP process active;
  - agent can read scene info;
  - agent can capture a viewport screenshot.

- **G2 — Agent visual-control loop**
  - agent makes one small controlled change;
  - captures screenshot;
  - visually confirms the result;
  - no success claim without proof.

- **G3 — SOLACE blockout**
  - metric units;
  - overall footprint and U-shaped organization recognizable;
  - courtyard, pool, principal wings/openings present at blockout level;
  - fixed QA cameras created;
  - screenshot evidence saved.

- **G4 — SOLACE hero-zone first pass**
  - living/dining/kitchen detailed enough to be recognizably related to references;
  - basic wood/plaster/glass/floor materials;
  - core furniture masses;
  - balanced interior/exterior exposure;
  - screenshots compared against references.

- **G5 — 10–14 s preview**
  - slow stable camera at human eye height;
  - living -> dining -> kitchen spatial continuity;
  - preview render only, not expensive final Cycles;
  - video artifact and validation notes saved.

---

## Critical-path rule

Do not spend the morning building infrastructure that is not required to cross the next gate.

Sequence:

`ACCESS -> MCP -> VISUAL LOOP -> SOURCE MANIFEST -> BLOCKOUT -> HERO ZONE -> CAMERA PREVIEW`

Not:

`ACCESS -> NEW FRAMEWORK -> NEW UI -> UE5 -> PHONE REMOTE -> MORE REPOS -> MAYBE BLENDER`

---

## Phase 0 — Freeze benchmark inputs

**Status:** in progress / repository references being committed.

Actions:

- keep all supplied SOLACE / Thomas reference images in `references/solace-astra/`;
- keep both supplied reference videos in the same package;
- maintain `references/solace-astra/README.md` with provenance, source names and hashes;
- do not overwrite the source package during generation.

Gate to exit: reference package visible from GitHub and documented.

---

## Phase 1 — Resolve Astra availability

**Timebox:** 10–15 min.

### API test

In PowerShell:

```powershell
py -m pip install -U openai
```

Then:

```powershell
@'
from openai import OpenAI
client = OpenAI()
model = client.models.retrieve("gpt-6-astra")
print("MODEL:", model.id)
response = client.responses.create(
    model="gpt-6-astra",
    reasoning={"effort":"low"},
    input="Responde exactamente: ASTRA_OK"
)
print(response.output_text)
'@ | py -
```

### Codex test

```powershell
codex debug models | Select-String "gpt-6-astra"
```

If visible:

```powershell
codex -m gpt-6-astra
```

Decision:

- **Astra API + Codex available:** use Astra in Codex.
- **Astra API available, Codex not:** keep direct API path as verified; use current Codex model for Blender MCP while we prepare direct Astra MCP integration separately.
- **Astra not yet provisioned:** do not block the project. Use the strongest available Codex model and record that G0 is `rollout pending`, not an MCP failure.

Gate to exit: exact access state known. No more guessing.

---

## Phase 2 — Install / validate September Blender MCP LAB

**Timebox:** 15–25 min.

Clone if needed:

```powershell
cd $HOME\Documents
git clone --branch lab/astra-sept-2026 --single-branch https://github.com/Juanmaes83/blender-mcp.git blender-mcp-astra-lab
cd blender-mcp-astra-lab
```

Run the prepared helper:

```powershell
.\scripts\setup-codex-blender-windows.ps1
```

In Blender:

1. enable `MCP for Blender`;
2. `N` panel -> `MCP for Blender`;
3. start MCP server;
4. save a LAB `.blend` before agent operations.

In Codex:

```text
/mcp
```

Verify `blender-astra-lab`.

Gate to exit: MCP listed and Blender bridge reachable.

---

## Phase 3 — Read-only visual health check

**Timebox:** 5–10 min.

Prompt:

```text
Inspect the currently open Blender scene. Do not modify anything.
Report all scene objects, then capture a viewport screenshot.
Visually inspect that screenshot before answering.
Report tool errors exactly. Do not claim success without the screenshot.
```

Required evidence:

- scene object list;
- viewport screenshot;
- no unreported errors.

If this fails, stop. Fix MCP before doing architecture.

Gate to exit: **G1**.

---

## Phase 4 — Controlled edit / proof of closed loop

**Timebox:** 5–10 min.

Prompt:

```text
Create one cube exactly 2m x 2m x 2m named LAB_TEST_CUBE.
Do not modify any other object.
Then inspect its dimensions, capture a viewport screenshot and visually verify the result.
If anything differs from the requested dimensions or is not visible, correct it before reporting success.
```

After success, the cube may be deleted.

Gate to exit: **G2**.

---

## Phase 5 — Create SOLACE source manifest BEFORE modeling

**Timebox:** 15–20 min.

Inputs:

- concept floorplan;
- living reference;
- kitchen reference;
- pool/exterior reference;
- Blender/Cycles board;
- UE5 board;
- process video;
- walkthrough video;
- `docs/ASTRA-SOLACE-BENCHMARK.md`.

Required artifact:

`benchmarks/solace/source_manifest.json`

Minimum fields:

```json
{
  "project": "SOLACE — The Garden House",
  "source_policy": "concept benchmark, not construction survey",
  "overall_dimensions_m": {"x": 25.40, "y": 17.00},
  "gross_enclosed_area_m2_approx": 305,
  "pool_m": {"length": 10.0, "width": 3.5},
  "program": ["3 bedrooms", "office", "living", "dining", "kitchen", "courtyard", "pool"],
  "hero_zone": ["living", "dining", "kitchen"],
  "reference_files": [],
  "uncertainties": [],
  "non_negotiables": []
}
```

Agent must identify uncertainties rather than invent precision.

Gate to exit: structured source manifest committed or saved locally with clear provenance.

---

## Phase 6 — Scene manifest + full villa blockout

**Timebox:** 45–75 min.

Required artifact:

`benchmarks/solace/scene_manifest.json`

Scene contract:

- metric scene;
- single-storey U-shaped residence around planted courtyard;
- principal wings and room adjacency consistent with concept plan;
- pool approximately 10 x 3.5 m;
- major glazing/openings represented;
- no decorative micro-detail yet;
- collections/naming deterministic;
- fixed validation cameras.

Recommended collections:

```text
SOLACE_ARCH
SOLACE_GLAZING
SOLACE_SITE
SOLACE_POOL
SOLACE_FURNITURE_BLOCKOUT
SOLACE_LIGHTS
SOLACE_CAMERAS_QA
```

Mandatory QA loop every major stage:

`INSPECT -> CHANGE -> SCREENSHOT -> COMPARE -> FIX`

Do not let the agent write the full project in one monolithic Python call.

Gate to exit: **G3**.

---

## Phase 7 — Hero-zone detail: living / dining / kitchen

**Timebox:** 45–90 min, only after G3.

Priority order:

1. camera / spatial proportions;
2. glazing + openings;
3. floor / wall / wood material families;
4. major furniture masses;
5. kitchen island + cabinetry;
6. dining table + seating;
7. lighting balance;
8. props only if they materially improve recognition.

Reference fidelity matters more than decorative quantity.

Create fixed comparison cameras corresponding approximately to:

- living/library board view;
- kitchen/dining board view;
- transition view linking the two spaces.

Gate to exit: **G4**.

---

## Phase 8 — First cinematic preview

**Timebox:** 30–45 min, stretch target.

Target:

- 10–14 s;
- 24 fps;
- approximately 240–336 frames;
- human eye camera height ~1.6 m;
- natural architectural focal range ~24–35 mm FF equivalent;
- stable movement;
- living -> dining -> kitchen;
- preview quality first (Eevee or low-cost Cycles depending scene readiness).

Do not attempt final 4K/8K today until motion and scene continuity pass.

Gate to exit: **G5**.

---

## What we deliberately postpone

Until the Blender benchmark is stable:

- UE5 transfer / walkable application;
- free-navigation collisions/interactions;
- iPhone remote controls;
- Ableton integration;
- full-villa final-detail pass;
- high-resolution final render;
- large autonomous web-research loop like the Palacio case;
- new custom MCP framework unless the current one proves insufficient.

These are next layers, not prerequisites for today's proof.

---

## Failure protocol

If a gate fails twice:

1. stop adding features;
2. save screenshot/log/error;
3. identify whether failure is `MODEL`, `MCP`, `BLENDER`, `SCENE`, `REFERENCE`, or `RENDER`;
4. fix the smallest failing layer;
5. rerun the same gate;
6. do not jump to a later phase to hide the failure.

Create evidence under a future `benchmarks/solace/runs/YYYY-MM-DD/` structure rather than leaving results only inside the agent session.

---

## End-of-day report format

At the end of the session record:

```text
Astra API access: YES / NO / PENDING
Astra through Codex: YES / NO / PENDING
Blender MCP G1: PASS / FAIL
Closed visual loop G2: PASS / FAIL
SOLACE blockout G3: PASS / FAIL
Hero zone G4: PASS / FAIL
Walkthrough G5: PASS / FAIL
Best screenshot/render path:
Best preview video path:
Blocking issue:
Next exact action:
```

The project advances on visible artifacts, not on agent claims.
