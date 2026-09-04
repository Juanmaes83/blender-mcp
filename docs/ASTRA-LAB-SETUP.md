# Astra / Codex + Blender MCP LAB — September 2026

Branch: `lab/astra-sept-2026`

Purpose: test a safe, current Blender MCP workflow with Codex and, when the API organization has access, GPT-6 Astra. Do not use `main` for the first experiments.

## 1. What this branch is

This LAB is based on the upstream `ahujasid/blender-mcp` September 2, 2026 head (package v1.9.1).

Important: this project uses `FastMCP` through the official Python `mcp` SDK (`mcp>=1.9.0,<2`). Do not install a separate `fastmcp` package just to update this project.

## 2. Windows prerequisites

- Blender 4.x or 5.x installed.
- Git installed.
- Python 3.10+; Python 3.11 is recommended for the MCP process.
- `uv` / `uvx` installed.
- Codex CLI installed if using the local Codex route.
- OpenAI API billing/key already configured if testing GPT-6 Astra directly through the API.

Install `uv` from PowerShell only if it is not already installed:

```powershell
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
```

Open a new PowerShell window afterwards.

Verify:

```powershell
uv --version
uvx --version
git --version
```

## 3. Clone this LAB

```powershell
cd $HOME\Documents
git clone --branch lab/astra-sept-2026 --single-branch https://github.com/Juanmaes83/blender-mcp.git blender-mcp-astra-lab
cd blender-mcp-astra-lab
```

Verify package version:

```powershell
Select-String -Path pyproject.toml -Pattern 'version ='
```

Expected: `1.9.1`.

## 4. Install/update the Blender addon

From the LAB folder:

```powershell
uv run blender-mcp install-addon
```

Then open Blender:

1. `Edit -> Preferences -> Add-ons`.
2. Search for `MCP for Blender`.
3. Enable it.
4. In the 3D viewport press `N`.
5. Open the `MCP for Blender` tab.
6. Click `Start MCP Server`.

Before experiments, save the `.blend` file.

## 5. Safe mode

For experiments driven by an AI agent, enable bounded Python execution.

For the current PowerShell session:

```powershell
$env:BLENDER_MCP_SAFE_MODE="1"
```

When Codex launches the MCP server directly, add the variable to the MCP entry instead (see the next section).

## 6. Connect Codex to this LAB

Remove/disable another Blender MCP entry first if one is already active. Only one MCP server should control the Blender addon at a time.

From PowerShell, with the LAB path adjusted if needed:

```powershell
codex mcp add blender-astra-lab --env BLENDER_MCP_SAFE_MODE=1 -- uv --directory "$HOME\Documents\blender-mcp-astra-lab" run blender-mcp
```

Check registration:

```powershell
codex mcp list
```

Then start Codex:

```powershell
codex
```

Inside Codex use `/mcp` and verify `blender-astra-lab` is active.

First validation prompt:

```text
Inspect the currently open Blender scene. Do not change anything yet. Report the objects and then capture a viewport screenshot so you can visually verify the scene.
```

Only after that succeeds, test one small change:

```text
Create one 2 meter cube named LAB_TEST_CUBE, capture a viewport screenshot, verify visually that it exists, and report exactly what tool calls succeeded or failed.
```

## 7. Test whether GPT-6 Astra is enabled for the API organization

ChatGPT web rollout and API access can arrive at different moments. The direct API request is the definitive test for the API organization/key in use.

With the OpenAI Python SDK configured in the environment:

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
    reasoning={"effort": "low"},
    input="Responde exactamente: ASTRA_OK"
)
print(response.output_text)
'@ | py -
```

Expected successful result:

```text
MODEL: gpt-6-astra
ASTRA_OK
```

Do not paste an API key into this repository or into chat.

If model retrieval/request returns `model_not_found`, the organization/key being used has not yet been provisioned for Astra. That is a rollout/access issue, not a Blender MCP issue.

## 8. Try Astra as the Codex model

Current Codex CLI supports a model override with `--model` / `-m`.

Try:

```powershell
codex --model gpt-6-astra
```

If Codex accepts and starts with Astra, run `/mcp` and repeat the read-only Blender validation. If Codex rejects the model while the direct API test succeeds, treat Codex model availability as a separate product-surface limitation and keep the Blender MCP setup intact.

## 9. First architectural-video slice

Do not begin with a full villa. Validate the loop first.

Target slice:

1. Read empty/current scene.
2. Create a 5 m x 4 m x 2.8 m room shell in metric units.
3. Add one large window opening.
4. Add a floor material and simple wall material.
5. Place camera at approximately 1.60 m eye height.
6. Add simple daylight/interior lighting.
7. Capture and inspect viewport.
8. Correct geometry/camera if necessary.
9. Create a 10-second camera move (240 frames at 24 fps).
10. Render a low-cost preview first; only then increase quality.

Mandatory agent loop:

```text
INSPECT -> CHANGE ONE STAGE -> CAPTURE -> VISUALLY VERIFY -> CORRECT -> CONTINUE
```

Never accept the agent's textual claim that a scene is correct without scene inspection or a viewport/render check.

## 10. Next step after the Blender slice works

The immersive-house target has two distinct outputs:

- Cinematic walkthrough video: can be validated entirely in Blender first.
- Walkable real-time experience: export geometry/materials/transforms and reconstruct/validate the level in Unreal Engine 5.

Do not start the Unreal layer until the Blender control + visual QA loop is stable.
