$ErrorActionPreference = "Stop"

Write-Host "=== Blender MCP + Codex LAB setup ==="

function Require-Command($Name, $Help) {
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        Write-Error "$Name is not available. $Help"
    }
}

Require-Command "uv" "Install uv from https://docs.astral.sh/uv/ and reopen PowerShell."
Require-Command "codex" "Install/update the OpenAI Codex CLI and reopen PowerShell."

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
Write-Host "Repo: $RepoRoot"

Write-Host "[1/4] Checking LAB package version..."
$PyProject = Join-Path $RepoRoot "pyproject.toml"
Select-String -Path $PyProject -Pattern '^version\s*=|^\s*"mcp>=' | ForEach-Object { Write-Host $_.Line }

Write-Host "[2/4] Installing/updating the Blender addon from this LAB..."
Push-Location $RepoRoot
try {
    & uv run blender-mcp install-addon
    if ($LASTEXITCODE -ne 0) { throw "Blender addon installation failed." }
}
finally {
    Pop-Location
}

Write-Host "[3/4] Registering this LAB as a local Codex MCP server..."
# Remove an earlier LAB registration if it exists. Ignore errors when absent.
try { & codex mcp remove blender-astra-lab 2>$null | Out-Null } catch { }

& codex mcp add blender-astra-lab --env BLENDER_MCP_SAFE_MODE=1 -- uv --directory $RepoRoot run blender-mcp
if ($LASTEXITCODE -ne 0) { throw "Codex MCP registration failed." }

Write-Host "[4/4] Current Codex MCP servers:"
& codex mcp list

Write-Host ""
Write-Host "SETUP COMPLETE."
Write-Host "Next:"
Write-Host "1. Open Blender."
Write-Host "2. Edit > Preferences > Add-ons: enable 'MCP for Blender'."
Write-Host "3. In the 3D viewport press N > MCP for Blender > Start MCP Server."
Write-Host "4. Run: codex"
Write-Host "5. Inside Codex run: /mcp"
Write-Host "6. Verify 'blender-astra-lab' is active."
Write-Host ""
Write-Host "First prompt:"
Write-Host "Inspect the currently open Blender scene. Do not change anything. Report the objects and capture a viewport screenshot for visual verification."
