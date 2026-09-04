# Rome + Environment Scaling — relevance to Astra / Blender / SOLACE

Date: 2026-09-04
Branch: `lab/astra-sept-2026`

## Executive conclusion

Both repositories are relevant, but at different layers.

- `Juanmaes83/rome` is a **future orchestration / persistence / governance layer**. It can eventually turn the Astra + Blender experiment into a persistent production system with reusable actions, skills, apps, memory, approvals and git-tracked capabilities.
- `Juanmaes83/awesome-environment-scaling` is **research / architecture guidance**, not a runtime component. Its strongest contribution to this project is the formal environment contract and the emphasis on verifiers, persistence and governed compounding.

Neither repository should be integrated into today's critical path before Astra/Codex -> Blender MCP -> visual QA works.

---

## 1. Rome audit

Repository: `Juanmaes83/rome` (fork of `rome-os/rome`).

Rome describes itself as an agentic OS that scales the environment around a model rather than only the model itself. Its central design is to preserve useful work as reusable, git-tracked capabilities.

Important primitives:

- **Actions** — typed executable operations.
- **Agents** — collaborators with their own instructions and tools.
- **Skills** — reusable procedures / domain knowledge.
- **Hooks** — lifecycle extensions.
- **Apps** — persistent purpose-built human interfaces.
- **Database/files** — app-private state that survives runs.
- **Governance / approvals** — authority can be bounded independently from capability.

Rome's self-evolution loop is effectively:

`CREATE -> DISCOVER -> COMPOSE -> ADAPT -> PRESERVE -> EVALUATE -> IMPROVE`

That maps strongly to the long-term Immersive Studio vision.

### Where Rome could sit later

```text
Human / Project Brief
        |
        v
   Rome / Immersive Studio
        |
        +--> Astra / Codex agent
        |
        +--> Blender MCP actions
        |
        +--> Reference / QA skills
        |
        +--> Render / benchmark history
        |
        +--> Approval gates
        |
        `--> future UE5 / Ableton / mobile actions
```

Potential future Rome actions:

- `inspect_blender_scene`
- `build_solace_blockout`
- `capture_qa_camera`
- `compare_reference_render`
- `render_walkthrough_preview`
- `export_scene_manifest`
- `send_to_unreal`

Potential persistent app: **Immersive Studio** — project dashboard with source references, current scene state, cameras, QA evidence, render history, failures, approvals and final outputs.

### Why Rome is NOT today's dependency

Rome is a substantial system: pnpm monorepo, Node 24+, pnpm 11.6, Docker/Compose, web dashboard and runtime. Adding it before the Blender control loop is proven would add infrastructure without proving the core 3D capability.

Decision: **mine architecture now, integrate later**.

Status for today's roadmap: `DEFERRED AFTER G5`.

---

## 2. Awesome Environment Scaling audit

Repository: `Juanmaes83/awesome-environment-scaling` (fork of `yunfanye/awesome-environment-scaling`).

This repository is a survey / curated research map. It is not a Blender or agent runtime library.

Its most useful formalism is the executable environment definition:

`E = (S, A, T, O, V, C, G)`

where:

- `S` — state;
- `A` — actions/tools;
- `T` — transitions;
- `O` — observations;
- `V` — verification/reward;
- `C` — constraints;
- `G` — goals / initial-state distribution.

The survey also makes three points directly relevant here:

1. **Verification is the binding constraint.** More generated environments or actions without trustworthy verification scales noise.
2. **Persistent environment scaling is distinct from simply retaining state.** What accumulates must be governed, reusable and maintainable.
3. **Environment quality/distribution matters more than raw quantity.** One high-fidelity, verifiable benchmark can be more useful than many shallow scenes.

These principles support the current decision to use SOLACE as a controlled benchmark instead of generating many arbitrary houses.

---

## 3. SOLACE as an executable agent environment

Using the survey's formalism, today's Blender benchmark can be explicitly defined as:

### S — State

- `.blend` scene;
- object hierarchy and transforms;
- source and scene manifests;
- materials;
- cameras;
- render settings;
- reference images/videos;
- run history and QA evidence.

### A — Actions

- Blender MCP scene inspection;
- Blender Python execution;
- object/material/camera manipulation;
- viewport screenshot;
- render preview;
- future asset retrieval / import.

### T — Transitions

- every Blender operation changes scene state;
- each stage must be deterministic enough to inspect and reproduce;
- major edits are incremental rather than one monolithic script.

### O — Observations

- scene/object metadata;
- viewport screenshots;
- fixed-camera renders;
- dimensions / transforms;
- render logs.

### V — Verifiers

This is the most important layer.

- architectural dimensions / adjacency checks;
- source-manifest non-negotiables;
- fixed-camera visual comparison;
- object existence / naming checks;
- camera continuity;
- final walkthrough inspection;
- human visual approval.

A model statement such as `done` is never a verifier.

### C — Constraints

- work only in LAB branch / LAB scene;
- `BLENDER_MCP_SAFE_MODE=1` during agent-generated code execution;
- preserve immutable references;
- no UE5 or extra infrastructure until Blender gates pass;
- no uncontrolled arbitrary external execution.

### G — Goals

Primary current goal:

`references -> coherent SOLACE Blender scene -> verified living/dining/kitchen slice -> 10–14 s architectural walkthrough preview`

Future goal distribution can include other homes, styles and source types only after the SOLACE benchmark is repeatable.

---

## 4. What these repos change in our strategy

They do **not** change today's sequence:

`ASTRA ACCESS -> MCP -> VISUAL LOOP -> SOURCE MANIFEST -> SOLACE BLOCKOUT -> HERO ZONE -> PREVIEW`

They do strengthen the architecture after the POC:

### Layer A — Model / reasoning

- GPT-6 Astra when available;
- Codex / Claude as alternate agent clients.

### Layer B — Executable environment

- Blender + Blender MCP;
- immutable references;
- source / scene manifests;
- screenshot and render verifiers;
- SAFE_MODE and gate policies.

### Layer C — Skills / production intelligence

- archviz;
- reference matching;
- camera cinematography;
- material / lighting workflows;
- QA loops.

### Layer D — Persistent operating system (later)

- Rome app/action/skill model;
- run history;
- approvals;
- project state;
- reusable capability discovery;
- cross-project learning.

### Layer E — downstream engines (later)

- Unreal Engine 5;
- Ableton / audio;
- mobile remote / Codex iOS assistant.

---

## 5. Integration decision

### Rome

**Use now:** concepts, capability model, persistence/governance design.

**Do not install today:** yes.

**Prototype integration after G5:** yes.

### Awesome Environment Scaling

**Use now:** benchmark contract, verifier-first architecture, terminology.

**Install as dependency:** no.

**Use as research registry for future scaling:** yes.

---

## Final recommendation

Today's most valuable move remains to prove the smallest closed loop in the real environment:

`AGENT -> BLENDER MCP -> BLENDER -> SCREENSHOT/RENDER -> VERIFIER -> CORRECTION`

Once that loop works on SOLACE, Rome becomes highly interesting as the layer that makes the capability persistent, inspectable and reusable across future real-estate projects.

The survey gives the design rule we should not compromise on: **scale the environment only after its verifiers are trustworthy.**
