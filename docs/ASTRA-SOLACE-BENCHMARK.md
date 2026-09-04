# Astra + Blender — SOLACE benchmark

Date: 2026-09-04
Branch: `lab/astra-sept-2026`

## Objective

Use the SOLACE / The Garden House material and the Thomas + Astra references as a controlled benchmark for an autonomous 3D production loop:

`BRIEF -> RESEARCH / REFERENCES -> SOURCE MANIFEST -> SCENE MANIFEST -> BLENDER MCP -> SCREENSHOT / RENDER -> VISUAL QA -> CORRECTION -> CINEMATIC WALKTHROUGH -> (LATER) UNREAL ENGINE 5`

The goal is not to prove that an LLM can write Blender Python. The goal is to prove that an agent can repeatedly inspect, build, verify and correct a coherent architectural scene from references.

## What the Thomas / Astra reference demonstrates

The reference material shows a workflow where Astra is given a target and quality criteria, then works with relatively little intervention. The described Palacio de Bellas Artes example includes autonomous research across many photographs, intermediate render generation, visual comparison against references, and use of documentary information for architectural dimensions.

The important pattern is therefore:

1. Broadly map the target before detail work.
2. Gather multiple reference views and documentary constraints.
3. Build a real 3D scene, not a 2D fake.
4. Produce intermediate renders.
5. Compare output to source material.
6. Correct geometry, framing, lighting and detail.
7. Only after scene coherence, create the cinematic output.

## Audit of the two supplied videos

### Video A — Blender / Astra process reference

Repository reference copy: `references/solace-astra/07_blender_astra_inmobiliaria_process_reference.mp4`

Source upload: `BLENDER ASTRA INMOBILIARIA 2.mp4`

Observed role: process + iteration.

Key stages visible in the edit:

- Blender starts close to the default/empty state.
- A large architectural blockout appears: walls, roof, glazing, exterior structures and site.
- Camera and scene iterations begin.
- Path-traced / converging renders are visible, confirming a true 3D render loop rather than a flat generative image pasted over Blender.
- The environment and forest context are progressively integrated.
- Later shots transition toward a more finished architectural camera move.

Important conclusion: the process is iterative. Bad framing, unconverged renders and imperfect close-ups appear during the work. The quality comes from repeated correction, not from a single perfect prompt.

### Video B — SOLACE cinematic walkthrough

Repository reference copy: `references/solace-astra/08_solace_walkthrough_reference.mp4`

Source upload: `VIDEO REFERENCIA BLENDER ASTRA INMOBILIARIA.mp4`

Observed role: final architectural flythrough reference.

Approximate sequence structure from the supplied file:

- `00:00 -> 14:03` — living -> dining -> kitchen.
- `14:03 -> 21:07` — office.
- `21:07 -> 23:07` — bathroom.
- `23:07 -> 32:10` — primary bedroom.
- end / loop returns toward the living sequence.

This is a cinematic architectural walkthrough, not yet a free-navigation immersive application. The later UE5 stage is a separate deliverable.

## Why the first 14 seconds are the correct POC slice

The living -> dining -> kitchen move is the highest-value minimum slice because it validates in one continuous spatial zone:

- scale;
- wall/opening placement;
- glazing;
- furniture hierarchy;
- materials;
- interior/exterior exposure;
- lighting;
- camera height/focal length;
- spatial continuity;
- cinematic motion.

The full villa can be blockout-level while this zone receives the first detail pass.

## SOLACE source-of-truth package

The supplied references provide more than a generic style moodboard:

- concept floorplan for a one-storey `3 bedrooms + office` residence;
- approximate overall dimensions around `25.40 m x 17.00 m`;
- gross enclosed area shown around `305 m²`;
- pool approximately `10 m x 3.5 m`;
- U-shaped organization around a planted courtyard;
- kitchen, living and pool exterior references;
- Blender/Cycles comparison board;
- Unreal Engine 5 comparison board;
- walkthrough video.

The plan itself is explicitly concept-level, not construction documentation. Dimensions must therefore be treated as benchmark constraints, not survey-grade truth.

## Blender vs Unreal comparison

The supplied comparison boards use almost the same seven scene views:

1. exterior / woodland residence;
2. living room + library;
3. kitchen + dining;
4. forest office;
5. primary bedroom;
6. bathroom;
7. garden + terrace / pool.

The key transfer target is scene semantics, not pixel identity:

- geometry;
- transforms;
- room relationships;
- cameras;
- material assignments;
- furnishing placement.

Blender/Cycles appears softer and more neutral; UE5 appears more contrasty and dramatic, particularly in exterior light. Therefore a future Blender -> UE5 handoff must preserve scene structure while accepting renderer-specific lighting reconstruction.

## Cinematography target

The walkthrough uses restrained real-estate cinematography:

- approximate human eye height around 1.5–1.7 m;
- natural wide focal range, approximately 24–35 mm full-frame equivalent;
- slow stable camera motion;
- very limited depth-of-field effect;
- no handheld shake;
- architecture remains readable throughout.

The benchmark should prioritize spatial legibility over FPV spectacle.

## Visual limitations in the reference

The reference is strong but not untouchable. Areas we can aim to improve:

- textiles / upholstery can read slightly synthetic in close shots;
- wood detail can be richer at near distance;
- some interiors are very dark;
- props repeat and reveal procedural simplicity;
- foreground vegetation is less convincing than mid/background vegetation;
- environmental motion is minimal.

The benchmark target is therefore `match structure and cinematic coherence first`, then improve material richness and life.

## Current technical stack decision

### Primary engine

`Juanmaes83/blender-mcp` LAB is based on upstream `ahujasid/blender-mcp` v1.9.1 from 2026-09-02.

Important characteristics:

- MCP SDK based server;
- `FastMCP` imported from the official `mcp` SDK;
- `mcp>=1.9.0,<2`;
- scene inspection;
- object inspection;
- viewport screenshots;
- Blender Python execution;
- asset integrations;
- `BLENDER_MCP_SAFE_MODE=1` for bounded agent-generated scripts.

Do not install a separate `fastmcp` package simply to modernize this repo.

### External repos worth mining

- `ahujasid/blender-mcp` — current upstream / source of truth for Blender MCP.
- `seehiong/blender-mcp-bridge` — useful architecture reference because it exposes Streamable HTTP MCP and a broad Blender tool surface.
- `arjun988/blender-skills` — 94 Blender skills including archviz, camera, scene assembly, QA and Unreal export workflows.
- `RobLe3/cc-blender-skill` — Claude Code Blender skill stack with source-locked reconstruction, multiview fit loops and Blender 5.1.1 validation.
- `webita/blender-codex-mcp` and `hassledzebra/codex_blender_mcp` — Codex-focused integration ideas; useful references, but not preferred as the primary engine over the September upstream.

### `codex-ios-assistant`

`Juanmaes83/codex-ios-assistant` is currently aligned with the external `Samin100/codex-ios-assistant` head inspected on 2026-09-04. It is not part of today's critical Blender path.

Future use: restricted remote studio controls such as status, latest render, trigger a known camera render, or request a screenshot. Do not expose arbitrary Blender Python through the phone bridge. The current iOS assistant design uses a bearer receiver token and documents that it does not yet provide request signatures, expiry or replay protection.

## Mandatory autonomous QA contract

No agent output is accepted because the agent says it succeeded.

Every meaningful stage must follow:

`INSPECT -> ACT -> CAPTURE -> VISUALLY VERIFY -> COMPARE -> CORRECT -> CONTINUE`

For the SOLACE benchmark specifically:

1. preserve source references;
2. create `source_manifest.json` before geometry;
3. create `scene_manifest.json` before detail work;
4. block out the full villa;
5. detail living/dining/kitchen first;
6. capture fixed validation cameras;
7. compare against supplied references;
8. record failures and repairs;
9. render a low-cost walkthrough preview;
10. only then increase render quality or move to UE5.

## Success gates

- **G0 — Access:** `gpt-6-astra` confirmed through API and/or accepted by Codex, or fallback model explicitly documented.
- **G1 — Agent/MCP:** agent reads the Blender scene and captures a viewport screenshot.
- **G2 — Controlled edit:** agent makes a small change and verifies it visually.
- **G3 — Geometry:** SOLACE blockout preserves floorplan logic, scale, courtyard, glazing and pool placement.
- **G4 — Visual slice:** living/dining/kitchen is recognizable against the source package.
- **G5 — Cinematic:** stable first-pass walkthrough approximating the first 14 s reference sequence.
- **G6 — UE5:** future stage only after G0–G5 are stable.
